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

users = User.all

# テスト用ユーザー
User.create!(
  name: "user",
  email: "user@example.com",
  password: "password",
  blog_url: "example.com",
  biography: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
)

User.create!(
  name: "aaa",
  email: "user2@example.com",
  password: "password",
  blog_url: "example.com",
  biography: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
)

# nameはアルファベットのみしか許容しない
50.times do
  length = rand(1..20)
  User.create!(
    name: Faker::Alphanumeric.alpha(number: length),
    email: Faker::Internet.email,
    blog_url: Faker::Internet.url,
    password: Faker::Internet.password,
    biography: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
  )
end

50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(content: content) }
end

# ユーザーフォローのリレーションシップを作成する
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

posts = Post.all
posts.each do |post|
  # ランダムなユーザーが「いいね」を付ける
  users.sample(rand(1..20)).each do |user|
    user.likes.create!(post: post)
  end
end
