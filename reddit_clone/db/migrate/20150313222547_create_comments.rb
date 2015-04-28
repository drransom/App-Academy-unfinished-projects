class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :author_id, index: true, null: false
      t.integer :post_id, index: true, null: false
      t.integer :parent_comment_id, index: true

      t.timestamps null: false
    end
  end
end
