class Url < ApplicationRecord
    validates_presence_of :url, :minified_url
end
