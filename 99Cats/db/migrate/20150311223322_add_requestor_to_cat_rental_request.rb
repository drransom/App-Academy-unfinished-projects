class AddRequestorToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :requestor_id, :integer, null: false
    add_index :cat_rental_requests, :requestor_id
  end
end
