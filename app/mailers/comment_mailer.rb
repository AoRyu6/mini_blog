# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def comment_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "新しいポストがつきました")
  end

  def send_top_liked_posts_email(user)
    @user = user
    posts = Post.all
    @posts = posts.top_liked
    mail(to: @user.email, subject: "いいねランキング[TOP 10]")
  end
end
