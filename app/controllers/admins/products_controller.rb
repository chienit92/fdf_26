class Admins::ProductsController < ApplicationController
  layout "admin_layout"
  before_action :logged_in_user, :verify_admin
  before_action :find_product, only: [:update, :destroy, :show]

  def index
    @product = Product.new
    @supports = Supports::Product.new
  end

  def new
    respond_to {|format| format.js}
  end

  def show
    @supports = Supports::Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to admins_products_path
      flash.now[:success] = t ".add_success"
    else
      render :new
    end
  end

  def update
    if @product.update_attributes product_params
      flash.now[:success] = t ".update_success"
      redirect_to admins_products_path
    else
      flash.now[:danger] = t ".update_fail"
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html {redirect_to admins_products_path}
      format.json {head :no_content}
      format.js {render layout: false}
    end
  end

  private
  def product_params
    params.require(:product).permit :name, :price, :available, :rate, :image,
      :classify, :category_id
  end

  def find_product
    @product = Product.find_by id: params[:id]
    unless @product
      flash[:danger] = t ".not_found"
      redirect_to admins_products_path
    end
  end
end
