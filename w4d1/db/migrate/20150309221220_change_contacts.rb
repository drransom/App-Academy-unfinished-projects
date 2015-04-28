class ChangeContacts < ActiveRecord::Migration
  def change
    remove_index :contacts, :user_id
    add_index :contacts, :user_id
  end
end
