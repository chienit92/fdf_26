class OrderDetailsController < ApplicationController
  include CheckOrder

  before_action :logged_in_user
  before_action :check_product_and_current_order, except: [:show, :new]
  before_action :find_order_detail, only: [:edit, :update, :destroy]
  before_action :check_product_in_cart, only: [:create]
  after_action :update_total_pay, only: [:create, :update, :destroy]

  def index
    @order_details = @order.order_details
  end

  def create
    @order_detail = @order.order_details.build order_detail_params
    if @order_detail.save
      flash[:success] = t "order.create_succ"
      redirect_to :back
    else
      flash[:danger] = t "order.create_err"
      redirect_to products_path
    end
  end

  def edit
  end

  def update
    if @order_detail.update_attributes order_detail_params
      flash[:success] = t "order.update_succ"
      redirect_to order_path
    else
      flash[:danger] = t "order.update_err"
      redirect_to :edit
    end
  end

  def destroy
    if @order_detail.destroy
      flash[:success] = t "order.destroy_succ"
      redirect_to order_details_path
    else
      flash[:danger] = t "order.destroy_err"
      redirect_to products_path
    end
  end

  private
  def check_product_in_cart
    order_detail = @order.order_details.find_by(product_id:
      params[:order_detail][:product_id])
    if order_detail
      order_detail.update_attributes unit_quantity:
        (order_detail.unit_quantity + params[:order_detail][:unit_quantity].to_i)
      flash[:success] = t "order.count"
      update_total_pay()
      redirect_to :back
    end
  end

  def order_detail_params
    params.require(:order_detail).permit :unit_quantity, :product_id
  end

  def find_order_detail
    @order_detail = @order.order_details.find params[:id]
  end

  def update_total_pay
    current_order[:total_pay] = current_order.subtotal
    current_order.save
  end
end
