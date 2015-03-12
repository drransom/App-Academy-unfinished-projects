class Singularize < ActiveRecord::Migration
  def change
    rename_column :logins, :ip_addresses, :ip_address
  end
end
