class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: {maximum: 100},
    uniqueness: {case_sensitive: false}

  scope :order_by_name, -> {order name: :asc}
end
