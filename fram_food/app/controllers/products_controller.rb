class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]
  before_action :find_product, only: :show

  def index
    @order_detail = current_order.order_details.new
    @products = Product.all
  end

  def show
    @order_detail = current_order.order_details.new
  end

  private
  def product_params
    params.require(:product).permit :name, :price, :available, :image,
      :classify, :category_id
  end

  def find_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t "controllers.products.not_exist"
      redirect_to root_path
    end
  end
end
