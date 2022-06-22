class AddUserIdToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :user_id, :string
  end
end
