class OrdersController < ApplicationController
  include CheckOrder

  before_action :logged_in_user, only: [:show, :update, :index]
  before_action :check_product_and_current_order, only: [:show, :update, :index]

  def show
    @order_details = @order.order_details
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "controllers.orders.ordered"
      redirect_to root_path
    end
    session.delete :order_id
    @current_order = nil
  end

  private
  def order_params
    params.require(:order).permit :status
  end
end
