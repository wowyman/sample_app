# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :google_token, :string
    add_column :users, :google_refresh_token, :string
  end
end