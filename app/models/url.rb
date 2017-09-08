class Url < ApplicationRecord
  validates_presence_of :url, :access
  scope :top, ->(limit) { order('access desc').limit(limit) }

  def self.process_url(url)
    u = Url.create(url: url)
    u.minified_url = "#{ENV.fetch('SHORT_URL_PROTOCOL')}://#{ENV.fetch('SHORT_URL_HOSTNAME')}/y/#{EncodingUrlService.instance.bijective_encode(u.id)}"
    u.access = u.access + 1
    u.save!
    u
  end

  # @param: minified_url {string} is the minified result from bijective_encode i.e (7yZ)
  def self.decode_url(minified_url)
    EncodingUrlService.instance.bijective_decode(minified_url.split('/').last)
  end

    def self.increase_access(minified_url)
     u = where(minified_url: minified_url)
     if(u.any?)
       u = u.first
       u.access += 1
       u.save!
     end
   end

  # @return: url {string} Long path url
  def self.lookup(minified_url)
    result_url = ''
    redis_cached_url = $redis.get(minified_url)
    if redis_cached_url.blank?
      # if the lookup is not in redis, we search in the database
      # if is not present, we return an empty string
      # if it's present, we return to outside and also we add it to redis so we can
      # return the cached result in the future.
      result = Url.find(Url.decode_url(minified_url))
      if result.present?
        url = result
        result.access += 1
        result.save
        result_url = result.url
      else
        # if there are no results, we need to return a 404
        result_url = "#{ENV.fetch('SHORT_URL_PROTOCOL')}://#{ENV.fetch('SHORT_URL_HOSTNAME')}/not-found"
      end
      $redis.set(minified_url, url.url)
    else
      # We return redis result and in an async manner we update the access
      complete_url = "#{ENV.fetch('SHORT_URL_PROTOCOL')}://#{ENV.fetch('SHORT_URL_HOSTNAME')}/y/#{minified_url}"
      AccessJob.perform_async(complete_url)
      result_url = redis_cached_url
    end
    result_url
end
end
