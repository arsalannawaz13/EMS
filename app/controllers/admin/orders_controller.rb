class Admin::OrdersController < ApplicationController
  def index
    if(Order.where(status: 1).nil?)
      flash[:notice] = 'No Active Orders'
      redirect_to root_path
    else
      @orders = Order.where(status: 1)
    end
  end
end
