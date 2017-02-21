class Admins::OrdersController < ApplicationController
  layout "admin_layout"
  before_action :logged_in_user, :verify_admin
  before_action :find_order, only: [:update, :show]

  def index
    @order_status = Order.statuses.keys
    @orders = Order.paginate page: params[:page], per_page: Settings.five
  end

  def show
  end

  def edit
  end

  def update
    if @order.update_attributes order_params
      flash.now[:success] = t ".update_success"
      respond_to do |format|
        format.html {redirect_to admins_orders_path}
        format.js {render layout: false}
      end
    else
      flash.now[:danger] = t ".update_fail"
    end
  end

  private
  def order_params
    params.require(:order).permit :status, :total_pay, :user_id, :order_detail_id
  end

  def find_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t ".not_found"
      redirect_to admins_orders_path
    end
  end
end
