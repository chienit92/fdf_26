class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if current_user.is_admin?
        redirect_to admins_products_path
      else
        redirect_to root_path
      end
    else
      flash[:danger] = t "controllers.sessions.invalid"
      redirect_to root_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
