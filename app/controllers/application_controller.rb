class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_log_in"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.is_admin?
      flash[:danger] = t "user_not_admin"
      redirect_to root_path
    end
  end

  def normal_user?
    if current_user
      if current_user.is_admin?
        flash[:danger] = t "flash.is_admin"
        redirect_to root_path
      end
    end
  end

  def check_column order
    Product.column_names.include?(order) ? order : "created_at"
  end
end
