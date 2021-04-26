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
    @category.save!
    redirect_to admin_categories_path
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
    @category.destroy!
    redirect_to admin_categories_path, notice: "Category deleted successfully"
  end


  private

  def category_params
    params.require(:product_category).permit(:title)
  end

  def set_category
    @category = ProductCategory.find(params[:id])
  end
end
