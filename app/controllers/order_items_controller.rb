class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_item, except: [:create]

  def create
    @order_item = @order.order_items.new(order_params)
    @order.save!
    session[:order_id] = @order.id
  end

  def update
    @order_item.update(order_params)
    @order_items = current_order.order_items
  end

  def destroy
    @order_item.destroy!
    @order_items = current_order.order_items
  end

  private

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end

  def set_order_item
    @order_item = @order.order_items.find(params[:id])
  end
end
