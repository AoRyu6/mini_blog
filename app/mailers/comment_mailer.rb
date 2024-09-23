# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def comment_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "新しいポストがつきました")
  end
end
