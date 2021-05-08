class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, except: [:index, :new, :create]
  before_action :set_categories, only: [:edit, :new]

  def index
    @products= Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Product Created!'
    else
      flash[:error] = 'Failed to create Product!'
    end
    redirect_to admin_products_path
  end

  def show; end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Product updated!'
      redirect_to admin_products_path
    else
      flash[:error] = 'Failed to edit Product!'
      render "edit"
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Product deleted successfully"
    else
      flash[:error] = 'Failed to delete Product!'
    end
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :description, :status, :product_category_id, :product_image)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @categories = ProductCategory.all
  end
end
