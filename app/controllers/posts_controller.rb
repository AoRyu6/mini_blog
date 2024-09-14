# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @pagy, @posts = pagy(Post.includes(:user).all)
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
