class LoginLocations < ActiveRecord::Migration
  def change
    add_column :logins, :ip_addresses, :integer
    add_column :logins, :machine_type, :string
  end
end
