# frozen_string_literal: true

class UrlSerializer < ActiveModel::Serializer
  attributes :url, :minified_url, :access
end
