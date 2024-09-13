# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Users", type: :request) do
  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }
    let(:archer) { FactoryBot.create(:user, :archer) }

    context "ログインしているとき" do
      before do
        sign_in user
      end

      it "自分のページにアクセスできること" do
        get user_path(user)
        expect(response).to(have_http_status(:success))
      end

      it "他のユーザーのページにアクセスできること" do
        get user_path(archer)
        expect(response).to(have_http_status(:success))
      end
    end

    context "ログインしていないとき" do
      it "自分のページにアクセスできないこと" do
        get user_path(user)
        expect(response).to(redirect_to(new_user_session_url))
      end

      it "他のユーザーのページにアクセスできないこと" do
        get user_path(archer)
        expect(response).to(redirect_to(new_user_session_url))
      end
    end
  end

  describe "PATCH /edit" do
    let(:user) { FactoryBot.create(:user) }
    context "ログインしているとき" do
      before do
        @name = "FooBar"
        @biography = "Hello"
        @blog_url = "example.com/"
        sign_in user

        patch user_registration_path, params: {
          user: {
            name: @name,
            biography: @biography,
            blog_url: @blog_url,
          },
        }
      end
      it "プロフィールの更新ができること" do
        user.reload
        expect(user.name).to(eq(@name))
        expect(user.biography).to(eq(@biography))
        expect(user.blog_url).to(eq(@blog_url))
      end
    end

    context "ログインしていないとき" do
      it "プロフィールの更新ができないこと" do
        @name = "FooBar"
        @biography = "Hello"
        @blog_url = "example.com/"
        patch user_registration_path, params: {
          user: {
            name: @name,
            biography: @biography,
            blog_url: @blog_url,
          },
        }
        expect(response).to(redirect_to(new_user_session_url))
      end
    end
  end
end
