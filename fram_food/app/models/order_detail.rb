class OrderDetail < ApplicationRecord
  has_many :products, dependent: :destroy

  has_one :discount

  belongs_to :order
end
