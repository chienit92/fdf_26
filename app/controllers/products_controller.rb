class ProductsController < ApplicationController
  before_action :logged_in_user, :normal_user?, only: [:show, :index]

  def index
    @order_detail = current_order.order_details.new
    @products = if params[:order] && params[:direction]
      order_prod Product
    elsif params[:direction]
      order_prod_rate Product
    else
      order_prod_default Product
    end
  end

  def show

    @order_detail = current_order.order_details.new
    @category = Category.all
    @product = Product.find_by_id params[:id]
    @comments = @product.comments.order_by_time
    @rating = Rating.new
    @votes = Rating.votes
    unless @product
       flash[:danger] = t "flash.prod_nil"
       redirect_to products_path
    end
  end
end
