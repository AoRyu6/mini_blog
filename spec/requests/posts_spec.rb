# frozen_string_literal: true

RSpec.describe("Posts", type: :request) do
  describe "GET /index" do
    it "レスポンスが200であること" do
      get posts_path
      expect(response).to(have_http_status(:ok))
    end
  end

  describe "POST /create" do
    context "ログインしているとき" do
      let(:user) { FactoryBot.create(:user) }

      it "新しいポストが作成されること" do
        sign_in user
        expect do
          post(posts_path, params: { post: { content: Faker::Lorem.characters(number: 140) } })
        end.to(change(Post, :count).by(1))
      end
      it "140字以上のときはポストが作成されないこと" do
        expect do
          post(posts_path, params: { post: { content: Faker::Lorem.characters(number: 141) } })
        end.not_to(change(Post, :count))
      end
    end

    context "未ログインのとき" do
      it "ポストが作成されないこと" do
        expect do
          post(posts_path, params: { post: { content: Faker::Lorem.characters(number: 140) } })
        end.not_to(change(Post, :count))
        expect(response).to(redirect_to(new_user_session_url))
      end
    end
  end
end
