class Supports::Product
  attr_reader :product

  def products
   @products = Product.all
  end

  def categories
    @categories = Category.all
  end

end
