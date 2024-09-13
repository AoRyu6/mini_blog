# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# テスト用ユーザー
User.create!(
  name: "user",
  email: "user@example.com",
  password: "password",
  biography: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
)

100.times do
  Post.create!(
    content: Faker::Books::TheKingkillerChronicle.book,
    user_id: 1,
  )
end

# nameはアルファベットのみしか許容しない
100.times do
  length = rand(1..20)
  User.create!(
    name: Faker::Alphanumeric.alpha(number: length),
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    biography: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
  )
end
