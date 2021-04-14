class UsersController < ApplicationController
  before_action :authenticate_user!

  def index;end

  def show
    @user = User.find(params[:id])
    render "user/show"
  end

  def edit
    @user = current_user
    render "user/edit"
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "user/edit"
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end
end
