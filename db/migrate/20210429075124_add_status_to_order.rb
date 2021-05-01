class AddStatusToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :boolean, default: false
  end
end
