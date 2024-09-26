# frozen_string_literal: true

class LikesController < ApplicationController
  # before_action :require_login

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)

    respond_to do |format|
      if like.save
        format.turbo_stream do
          render(turbo_stream: turbo_stream.update(
            "post_#{post.id}_like",
            partial: "posts/like",
            locals: { post: post },
          ))
        end
      else
        format.html { redirect_to(post, alert: "Failed to favorite.") }
      end
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    post = Post.find(params[:post_id])

    respond_to do |format|
      if like.destroy
        format.turbo_stream do
          render(turbo_stream: turbo_stream.replace(
            "post_#{post.id}_like",
            partial: "posts/like",
            locals: { post: post },
          ))
        end
      else
        format.html { redirect_to(post, alert: "Failed to unfavorite.") }
      end
    end
  end
end
