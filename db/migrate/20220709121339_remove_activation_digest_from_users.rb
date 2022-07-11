class RemoveActivationDigestFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :activation_digest, :string
  end
end
