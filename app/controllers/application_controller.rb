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

  def order_prod obj
    obj.order_by(check_column(params[:order]),
      check_direction(params[:direction]))
      .paginate page: params[:page], per_page: Settings.size
  end

  def order_prod_rate obj
    obj.order_by_rate(check_direction params[:direction])
      .paginate page: params[:page], per_page: Settings.size
  end

  def order_prod_default obj
    obj.order_by("created_at", "desc")
      .paginate page: params[:page], per_page: Settings.size
  end

  def check_column order
    Product.column_names.include?(order) ? order : t("filter.created_at")
   end

  def check_direction direction
    t("filter.asc") == direction ? t("filter.desc") : t("filter.asc")
  end

  def store_locate
    session.delete(:return_to) unless session[:return_to]
    session[:return_to] ||= request.url if request.get?
  end
end
