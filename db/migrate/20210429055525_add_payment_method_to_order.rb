class AddPaymentMethodToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :payment_method, :string, default: 'Cash-On-Delivery'
  end
end
