class ChangeIpAddress < ActiveRecord::Migration
  def change
    change_column :logins, :ip_addresses, :string
  end
end
