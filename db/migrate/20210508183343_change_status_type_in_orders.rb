class ChangeStatusTypeInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column(:orders, :status, :integer, default: 0)
  end
end
