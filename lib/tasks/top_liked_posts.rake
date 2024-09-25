# frozen_string_literal: true

namespace :top_liked_posts do
  desc "全てのユーザに朝7:00にトップ10のランキングメールを送る"
  task send_email: :environment do
    User.find_each do |user|
      CommentMailer.send_top_liked_posts_email(user).deliver
    end
  end
end
