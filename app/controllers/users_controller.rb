class UsersController < ApplicationController
  before_action :find_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash.now[:success] = t "controllers.users.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash.now[:success] = t "controllers.users.profile_update"
      redirect_to @user
    else
      flash.now[:danger] = t "controllers.users.error_update"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :phone
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash.now[:danger] = t "controllers.users.not_found"
      redirect_to root_path
    end
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end
end
