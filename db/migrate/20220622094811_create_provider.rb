class CreateProvider < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :user_id
      t.string :provider
      t.string :name
    end
  end
end
