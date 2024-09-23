# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def comment_email
    user = User.first
    post = user.posts.first
    CommentMailer.comment_email(user, post)
  end
end
