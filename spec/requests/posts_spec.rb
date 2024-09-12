# frozen_string_literal: true

RSpec.describe("Posts", type: :request) do
  describe "POST /create" do
    context "有効な値のとき" do
      it "新しいポストが作成されること" do
        expect do
          post(posts_path, params: { post: { content: Faker::Lorem.characters(number: 140) } })
        end.to(change(Post, :count).by(1))
      end
    end

    context "無効な値のとき" do
      it "ポストが作成されないこと" do
        expect do
          post(posts_path, params: { post: { content: Faker::Lorem.characters(number: 141) } })
        end.not_to(change(Post, :count))
      end
    end
  end
end
