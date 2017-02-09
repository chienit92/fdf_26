class Order < ApplicationRecord
  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy

  belongs_to :user
end
