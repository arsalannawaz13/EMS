class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :list]
  helper_method :sort_column, :sort_direction

  def index
    @users= User.all
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = 'attachment; filename="ems-users-list.csv"'
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User updated!'
      redirect_to admin_users_list_path
    else
      flash[:error] = 'Failed to edit User!'
      render "edit"
    end
  end

  def list
    @results= User.search(params[:term]).order(sort_column + " " + sort_direction).page(params[:page]).per(5)
  end

  def destroy
    @user.destroy
    redirect_to admin_users_list_path, notice: "User deleted successfully"
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "full_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def set_user
    @user = User.find(params[:id])
  end
end
