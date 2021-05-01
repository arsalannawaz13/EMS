class OrdersController < ApplicationController
  after_action :empty_cart, only: [:update]
  def update
    @order = current_order
    @order.status = true
    @order.save!
    flash[:notice] = 'Order Placed Successfully!'
    redirect_to products_path
  end

  private

  def empty_cart
  end
end
