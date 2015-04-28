class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :session_token, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :logins, :session_token, unique: true
    add_index :logins, :user_id
  end
end
