class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :answer_choice_id, null: false

      t.timestamps
    end
    add_index :responses, [:user_id, :answer_choice_id]
    add_index :answer_choices, [:question_id]

  end
end
