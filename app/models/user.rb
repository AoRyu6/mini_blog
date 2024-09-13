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
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
end
