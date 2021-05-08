class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories= ProductCategory.all
  end

  def new
    @category = ProductCategory.new
  end

  def create
    @category = ProductCategory.new(category_params)
    if @category.save
      flash[:notice] = 'Category Created!'
      redirect_to admin_categories_path
    else
      flash[:error] = 'Failed to create Category!'
      new_admin_category_path
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category updated!'
      redirect_to admin_categories_path
    else
      flash[:error] = 'Failed to edit Category!'
      render "edit"
    end
  end

  def destroy
    if (Product.where(product_category_id: @category)).any?
      flash[:notice] = 'First delete all products with this category!'
      redirect_to admin_categories_path
    else
      @category.destroy!
      redirect_to admin_categories_path, notice: "Category deleted successfully"
    end
  end

  private

  def category_params
    params.require(:product_category).permit(:title)
  end

  def set_category
    @category = ProductCategory.find(params[:id])
  end
end
