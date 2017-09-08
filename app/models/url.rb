# frozen_string_literal: true

class Url < ApplicationRecord
  validates_presence_of :url, :access
  scope :top, ->(limit) { order('access desc').limit(limit) }

  def self.process_url(url)
    u = Url.create(url: url)
    u.minified_url = "http://#{ENV.fetch('SHORT_URL_HOSTNAME')}/#{EncodingUrlService.new.bijective_encode(u.id)}"
    u.access = u.access + 1
    u.save!
    u
  end

  def increase_access(minified_url)
    u = where(minified_url: minified_url)
    u.access += 1
    u.save!
  end

  def lookup
    minified_url = params[:minified_url]
    result_url = ''
    redis_cached_url = $redis.get(minified_url)
    if redis_cached_url.blank?
      # if the lookup is not in redis, we search in the database
      # if is not present, we return an empty string
      # if it's present, we return to outside and also we add it to redis.
      result = Url.where(minified_url: minified_url)
      if result.any?
        url = result.first
        url.access += 1
        url.save
        $redis.set(minified_url, url.url)
        result_url = url
      end
    else
      # We return redis result and in an async manner we update the access
      AccessJob.perform_async(minified_url)
      result_url = redis_cached_url
    end
    result_url
end
end
