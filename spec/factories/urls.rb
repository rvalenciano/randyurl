# frozen_string_literal: true
require 'faker'

FactoryGirl.define do
  factory :url do
    url { Faker::Internet.url }
    minified_url 'http://randyurl/879879797978'
    access 0

    trait :accessed do
      access {Faker::Number.between(1, 100)}
    end

  end
end
