class Discount < ApplicationRecord
  has_many :discount_products, dependent: :destroy
  has_many :products, through: :discount_products
end
