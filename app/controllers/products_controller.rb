class ProductsController < ApplicationController
  before_action :logged_in_user, :normal_user?, only: [:show, :index]

  def show
    @category = Category.all
    @product = Product.find_by id: params[:id]
    @comment= Comment.new
    @rate = Rating.new
    @votes = Rating.votes
    @comments = @product.comments.order_by_time
    @order_detail = current_order.order_details.new
    if @product.nil?
      flash[:danger] = t "flash.prod_nil"
      redirect_to products_path
    end
  end

  def index
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
