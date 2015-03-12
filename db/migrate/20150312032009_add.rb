class Add < ActiveRecord::Migration
  def change
    add_column :logins, :latitude, :integer
    add_column :logins, :longitude, :integer
  end
end
