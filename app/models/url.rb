# frozen_string_literal: true

class Url < ApplicationRecord
  validates_presence_of :url, :minified_url
end
