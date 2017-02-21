class Admins::UsersController < ApplicationController
  layout "admin_layout"
  before_action :logged_in_user, :verify_admin
  before_action :find_user, only: [:destroy]

  def index
    @users = User.all
    @users = User.paginate page: params[:page], per_page: Settings.five
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to admins_users_path}
      format.json {head :no_content}
      format.js {render layout: false}
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :address, :email, :phone
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".not_found"
      redirect_to admins_users_path
    end
  end
end
