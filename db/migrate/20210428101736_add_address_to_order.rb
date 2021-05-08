class AddAddressToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address, :text
    add_column :orders, :city, :string
    add_column :orders, :country, :string
    add_column :orders, :zip_code, :integer
  end
end
