class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false, index: true
      t.integer :post_id, null: false, index: true

      t.timestamps
    end
  end
end
