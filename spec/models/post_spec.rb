# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Post, type: :model) do
  describe "#validate" do
    context "無効な値が入力されたとき" do
      it "コンテンツが141字以上の場合、バリデーションエラーとなること" do
        invalid_post = FactoryBot.build(:post, content: Faker::Lorem.characters(number: 141))
        invalid_post.valid?
        expect(invalid_post.errors[:content]).to(include("は140文字以内で入力してください"))
      end
    end
  end
end
