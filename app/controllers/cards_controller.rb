class CardsController < ApplicationController

  def show
    if !(current_order.order_items.any?)
      flash[:notice] = 'Your Cart is Empty'
      redirect_to products_path
    else
      @order_items = current_order.order_items
      @order = current_order
    end
  end

  def update
    @order = current_order
    if @order.update(order_params)
      flash[:notice] = 'Customer Info updated!'
    else
      flash[:error] = 'Failed to Add Customer Info!'
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :country, :zip_code, :payment_method)
  end
end
