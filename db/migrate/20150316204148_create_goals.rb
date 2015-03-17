class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :content, null: false
      t.integer :user_id, index: true, null: false
      t.boolean :private, null: false

      t.timestamps null: false
    end
  end
end
