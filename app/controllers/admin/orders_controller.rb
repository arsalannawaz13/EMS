class Admin::OrdersController < ApplicationController
  def index
    if(Order.where(status: true).nil?)
      flash[:notice] = 'No Active Orders'
      redirect_to root_path
    else
      @order = Order.where(status: true)
    end
  end
end
