class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, except: [:index, :update_password, :show]
  helper_method :sort_column, :sort_direction

  def list
    @results= User.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(5)
    render "admin/users/list"
  end

  def index
    @users= User.all
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = 'attachment; filename="ems-users-list.csv"'
        headers['Content-Type'] ||= 'text/csv'
      end
    end
    render "admin/users/index"
  end

  def update_user_details
    if @user.update(user_update_params)
      flash[:notice] = 'User updated!'
      redirect_to admin_users_list_path
    else
      flash[:error] = 'Failed to edit User!'
      render "admin/users/update_user"
    end
  end

  def update_user
    render "admin/users/update_user"
  end

  def show
    @user = User.find(params[:id])
    render "admin/users/show"
  end

  def destroy
    @user.destroy
    redirect_to admin_users_list_path, notice: "User deleted successfully"
  end

  def update_password
    if current_user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(current_user)
      redirect_to root_path
    else
      render "admin/users/edit"
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_update_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "full_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def find_user
    @user = User.find(params[:format])
  end
end
