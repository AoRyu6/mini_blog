# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to(post_url(@post), alert: "Failed to create")
    else
      redirect_to(request.referer)
    end
  end

  def destroy
  end

  def new
    @post = Post.find(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
