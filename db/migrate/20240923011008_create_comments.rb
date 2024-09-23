# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table(:comments) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.text(:body, null: false, default: "")
      t.references(:post, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
