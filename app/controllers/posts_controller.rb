# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

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
