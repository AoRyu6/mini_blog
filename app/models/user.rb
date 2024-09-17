# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 20 },
    format: {
      with: /\A[a-zA-Z]+\z/,
      message: "はアルファベットのみが使えます",
    }
  validates :biography, length: { maximum: 200 }
  has_many :posts, dependent: :destroy
  has_many :active_relationships,
    class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent:   :destroy,
    inverse_of:  :follower

  has_many :passive_relationships,
    class_name:  "Relationship",
    foreign_key: "followed_id",
    dependent:   :destroy,
    inverse_of:  :followed

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    following.delete(other_user)
  end

  # 現在のユーザーが他のユーザーをフォローしていればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
