class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title, null: false, unique: true
      t.text :description
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
  end
end
