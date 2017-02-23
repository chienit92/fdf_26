class CategoriesController < ApplicationController
   before_action :logged_in_user, :normal_user?, only: [:show, :index]

  def show
    @category = Category.find_by id: params[:id]
    @order_detail = current_order.order_details.new
    if @category.nil?
      flash[:danger] = t "flash.cate_nil"
      redirect_to categories_path
    else
      if params[:order] && params[:direction]
        @products = @category.products.order_by(check_column(params[:order]),
          check_direction(params[:direction]))
          .paginate page: params[:page], per_page: Settings.five
      elsif params[:direction]
        @products = @category.products.order_by_rate(check_direction params[:direction])
          .paginate page: params[:page], per_page: Settings.five
      else
        @products = @category.products..order_by("created_at", "desc")
          .paginate page: params[:page], per_page: Settings.five
      end
    end
  end

  def index
    @categories = Category.all.order_by_name
    @order_detail = current_order.order_details.new
    if params[:order] && params[:direction]
      @products = Product.order_by(check_column(params[:order]),
        check_direction(params[:direction]))
        .paginate page: params[:page], per_page: Settings.five
    elsif params[:direction]
      @products = Product.order_by_rate(check_direction params[:direction])
        .paginate page: params[:page], per_page: Settings.five
    else
      @products = Product.order_by("created_at", "desc")
        .paginate page: params[:page], per_page: Settings.five
    end
  end
end
