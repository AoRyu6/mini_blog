# frozen_string_literal: true

class AddBlogUrlToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column(:users, :blog_url, :string, null: false, default: "")
  end
end
