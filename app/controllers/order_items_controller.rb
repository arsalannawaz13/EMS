class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_order_item, except: [:create]

  def create
    index = @order.order_items.pluck(:product_id).index(params[:order_item][:product_id].to_i)
    if (index)
      @order.order_items[index].quantity += params[:order_item][:quantity].to_i
      @order.order_items[index].save!
    else
      @order_item = @order.order_items.new(order_params)
    end
    @order.user_id = current_user.id
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
