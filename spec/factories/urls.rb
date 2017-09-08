# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :url do
    url { Faker::Internet.url }
    id { Faker::Number.unique.between(1, 1000000) }
    minified_url 'http://localhost:3000/2Ye'
    access 0

    trait :accessed do
      access { Faker::Number.between(1, 100) }
      id { Faker::Number.unique.between(1, 1000000) }
    end

    trait :accessed_once do
      access 1
      minified_url 'http://localhost:3000/2Ye'
      id { Faker::Number.unique.between(1, 1000000) }
    end

    trait :accessed_twice do
      access 2
      minified_url 'http://localhost:3000/2Ye'
      id { Faker::Number.unique.between(1, 1000000) }
    end
  end
end
