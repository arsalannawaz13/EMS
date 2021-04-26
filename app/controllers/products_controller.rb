class ProductsController < ApplicationController

  def index
    @products= Product.where(status: 'publish')
  end
end
