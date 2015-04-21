class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :poll_id, null: false

      t.timestamps
    end

    add_index :questions, [:poll_id]

    change_column :polls, :author_id, :integer, null: false
    change_column :polls, :title, :string, null: false
  end
end
