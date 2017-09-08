class UrlSerializer < ActiveModel::Serializer
  attributes :url, :minified_url, :access
end
