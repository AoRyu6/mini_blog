# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "user" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    biography { "自己紹介" }

    trait :archer do
      name { "archer" }
    end
  end
end
