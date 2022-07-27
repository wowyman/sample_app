class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :micropost, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :post_parent_id, null: true
      t.timestamps
    end
  end
end
