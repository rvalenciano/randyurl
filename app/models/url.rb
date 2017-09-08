# frozen_string_literal: true

class Url < ApplicationRecord
  validates_presence_of :url, :access
  scope :top, ->(limit) { order('access desc').limit(limit) }

  def process_url(url)
    self.url = url
    self.minified_url = 'http://randyurl/879879797978'
    self.access = access + 1
  end
end
