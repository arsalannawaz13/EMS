class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.where(status: true)
  end
end
