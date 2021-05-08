class OrdersController < ApplicationController
  def update
    @order = current_order
    @order.status = 1
    @order.save!
    flash[:notice] = 'Order Placed Successfully!'
    redirect_to products_path
  end
end
