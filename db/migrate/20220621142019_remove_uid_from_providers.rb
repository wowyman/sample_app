class RemoveUidFromProviders < ActiveRecord::Migration[6.0]
  def change
    remove_column :providers, :uid, :string
  end
end
