class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :content, presence: true, length: {maximum: 500}

  scope :order_by_created_at, ->{order created_at: :desc}
end
