# frozen_string_literal: true

require "rails_helper"

RSpec.describe(User, type: :model) do
  context "#validate" do
    it "名前が20字以上のときバリデーションエラーになること" do
      invalid_user = FactoryBot.build(:user, name: Faker::Lorem.characters(number: 21))
      invalid_user.valid?
      expect(invalid_user.errors[:name]).to(include("は20文字以内で入力してください"))
    end

    it "名前はアルファベットのみで可能であること" do
      invalid_names = ["123", "ユーザー"]
      invalid_names.each do |name|
        user = FactoryBot.build(:user, name: name)
        expect(user).not_to(be_valid)
        expect(user.errors[:name]).to(include("はアルファベットのみが使えます"))
      end
    end
    it "自己紹介文が200字を超えるとエラーになること" do
      invalid_biography = FactoryBot.build(:user, biography: Faker::Lorem.characters(number: 2001))
      expect(invalid_biography).to_not(be_valid)
    end
  end
end
