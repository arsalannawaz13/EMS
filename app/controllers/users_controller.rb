class UsersController < ApplicationController
  before_action :authenticate_user!

  def list
    if params[:search].blank?  
      @results = User.all
    else  
      @parameter = params[:search].downcase  
      @results = User.all.where("lower(full_name) LIKE ? or lower(email) LIKE ? or lower(admin) LIKE ?", "%" + @parameter + "%", "%" + @parameter + "%", "%" + @parameter + "%")
    end  
    render "user/list"
  end

  def update_user_details
    @user = User.find(params[:format])
    if @user.update(user_update_params)   
      flash[:notice] = 'User updated!'   
      redirect_to users_list_path   
    else   
      flash[:error] = 'Failed to edit User!'   
      render "user/update_user" 
    end   
  end

  def update_user
    @user = User.find(params[:format])
    render "user/update_user"
  end

  def show
    @user = User.find(params[:id])
    render "user/show"
  end

  def destroy
    @users = User.find(params[:format])
    @users.destroy
    redirect_to users_list_path, notice: "User deleted successfully"
  end

  def edit
    render "user/edit"
  end

  def update_password
    if current_user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(current_user)
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

    def user_update_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
