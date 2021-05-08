module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column) && (sort_direction == "asc") ? "desc" : "asc"
    link_to title, sort: column, direction: direction
  end

  def current_order
    if session[:order_id].present?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
