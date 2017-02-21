def Product_all
  products = if params[:order] && params[:direction]
      Product.order_by(check_column(params[:order]), check_direction(params[:direction]))
    elsif params[:direction]
      Product.order_by_rate check_direction params[:direction]
    else
      Product.all
    end
end
