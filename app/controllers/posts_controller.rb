# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @pagy, @posts = if params[:filter] == "following"
      # フォロー中のユーザーのポストのみ取得
      pagy(Post.includes([:user]).where(user_id: current_user.following_ids).order(created_at: :desc))
    else
      # すべてのポストを取得
      pagy(Post.includes(:user).order(created_at: :desc))
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to(@post, notice: "作成しました")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
