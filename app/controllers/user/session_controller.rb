class User::SessionController < Devise::SessionsController
  def destroy
    if(current_order.status = false)
      current_order.destroy
    end
    super
  end
end
