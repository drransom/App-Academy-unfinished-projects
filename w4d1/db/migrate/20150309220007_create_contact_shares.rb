class CreateContactShares < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.integer :contact_id, references: :contacts, null: false
      t.integer :user_id, references: :users, null: false

      t.timestamps null: false
    end

    add_index :contact_shares, [:contact_id, :user_id], unique: true
    add_index :contact_shares, :contact_id
    add_index :contact_shares, :user_id
  end
end