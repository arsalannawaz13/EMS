module Admin::ProductsHelper
  def categories_title(categories)
    categories.pluck(:title)
  end
end
