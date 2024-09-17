# frozen_string_literal: true

require "rails_helper"

RSpec.describe("Relationships", type: :request) do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, :archer) }

  describe "#create" do
    context "ログイン中の場合" do
      before do
        sign_in user
      end
      it "フォローできること(通常)" do
        expect do
          post(relationships_path, params: { followed_id: other_user.id })
        end.to(change(Relationship, :count).by(1))
      end
      it "フォローできること(Hotwire)" do
        expect do
          post(relationships_path(format: :turbo_stream), params: { followed_id: other_user.id })
        end.to(change(Relationship, :count).by(1))
      end
    end
    context "未ログインの場合" do
      it "ログインページにリダイレクトすること" do
        post relationships_path
        expect(response).to(redirect_to(new_user_session_url))
      end

      it "登録されないこと" do
        expect do
          post(relationships_path)
        end.to_not(change(Relationship, :count))
      end
    end
  end
  describe "#destroy" do
    context "ログイン中の場合" do
      before do
        sign_in user
        user.follow(other_user)
      end
      it "フォロー解除ができること(通常)" do
        relationship = user.active_relationships.find_by(followed_id: other_user.id)
        expect do
          delete(relationship_path(relationship))
        end.to(change(Relationship, :count).by(-1))
      end
      it "フォロー解除ができること(Hotwire)" do
        relationship = user.active_relationships.find_by(followed_id: other_user.id)
        expect do
          delete(relationship_path(relationship, format: :turbo_stream))
        end.to(change(Relationship, :count).by(-1))
      end
    end
  end
end
