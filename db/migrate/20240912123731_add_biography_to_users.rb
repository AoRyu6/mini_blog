# frozen_string_literal: true

class AddBiographyToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column(:users, :biography, :text, null: false, default: "")
  end
end
