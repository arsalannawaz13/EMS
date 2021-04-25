class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, except: [:index, :new, :create]

  def index
    @products= Product.all
  end

  def new
    @product = Product.new
    @categories = ProductCategory.all
  end

  def create
    product_category_id = ProductCategory.find_by(title: params[:product][:product_category_id]).id
    params[:product][:product_category_id] = product_category_id
    @product = Product.new(product_params)
    @product.save!
    redirect_to admin_products_path
  end

  def show; end

  def edit
    @categories = ProductCategory.all
  end

  def update
    product_category_id = ProductCategory.find_by(title: params[:product][:product_category_id]).id
    params[:product][:product_category_id] = product_category_id
    if @product.update(product_params)
      flash[:notice] = 'Product updated!'
      redirect_to admin_products_path
    else
      flash[:error] = 'Failed to edit Product!'
      render "edit"
    end
  end

  def destroy
    @product.destroy!
    redirect_to admin_products_path, notice: "Product deleted successfully"
  end


  private

  def product_params
    params.require(:product).permit(:title, :price, :description, :status, :product_category_id, :product_image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
