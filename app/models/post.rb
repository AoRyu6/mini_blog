# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image do |attachable|
    attachable.variant(:display, resize_to_limit: [540, 960])
  end
  validates :image,
    content_type: {
      in: ["image/jpeg", "image/gif", "image/png"],
      message: "有効なフォーマットではありません",
    },
    size: { less_than: 5.megabytes, message: "5MBまでです" }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  scope :top_liked, -> {
    joins(:likes)
      .group("posts.id")
      .order("COUNT(likes.id) DESC")
      .limit(10)
  }
end
