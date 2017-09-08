# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :url do
    url { Faker::Internet.url }
    minified_url 'http://randyurl/879879797978'
    access 0

    trait :accessed do
      access { Faker::Number.between(1, 100) }
    end

    trait :accessed_once do
      access 1
      minified_url 'http://randyurl/879879797978'
    end

    trait :accessed_twice do
      access 2
      minified_url 'http://randyurl/879879797978'
    end
  end
end
