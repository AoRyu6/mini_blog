# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/comment_mailer
class CommentMailerPreview < ActionMailer::Preview
  def comment_email
    user = User.first
    post = user.posts.first
    CommentMailer.comment_email(user, post)
  end

  def send_top_liked_posts_email
    user = User.first
    posts = Post.all
    @posts = posts.top_liked
    CommentMailer.send_top_liked_posts_email(user)
  end
end
