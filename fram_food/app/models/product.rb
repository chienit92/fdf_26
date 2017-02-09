class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :discount_products, dependent: :destroy
  has_many :discounts, through: :discount_products

  belongs_to :order_detail
  belongs_to :category
end
