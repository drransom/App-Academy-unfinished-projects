class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.integer :voter_id, null: false, index: true
      t.integer :votable_id, null: false, index: true
      t.string :votable_type, null: false

      t.timestamps null: false
    end
    add_index :votes, [:votable_id, :votable_type]
    add_index :votes, [:voter_id, :votable_id, :votable_type], unique: true
  end
end
