module CheckOrder
  def check_product_and_current_order
    @order = Order.find_by id: session[:order_id]
    unless @order
      @order = Order.create user_id: current_user.id
      session[:order_id] = @order.id
    end
    if params[:order_detail]
      @product = Product.find_by id: params[:order_detail][:product_id]
      unless @product
        flash[:danger] = t "controllers.orders.product_nil"
        redirect_to root_path
      end
    end
  end
end
