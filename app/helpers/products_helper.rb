module ProductsHelper
  def default_image product
    if product.image.blank?
      image_tag("http://images.indiatvnews.com/lifestylelifestyle/2014/food-fact1.jpg",
        size: "150x100", class: "img-thumbnail")
    else
      image_tag(product.image.url, class: "img-thumbnail")
    end
  end
end
