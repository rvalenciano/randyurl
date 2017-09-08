# frozen_string_literal: true

class Url < ApplicationRecord
  validates_presence_of :url, :access
  scope :top, ->(limit) { order('access desc').limit(limit) }
end
