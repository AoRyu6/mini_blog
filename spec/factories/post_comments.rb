# frozen_string_literal: true

FactoryBot.define do
  factory :post_comment do
    user { nil }
    comment { "MyText" }
    post { nil }
  end
end
