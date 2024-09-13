# frozen_string_literal: true

# rubocop:disable Rails/NotNullColumn
class AddUserRefToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference(:posts, :user, null: false, foreign_key: true)
  end
end

# rubocop:enable Rails/NotNullColumn
