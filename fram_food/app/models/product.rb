class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :discount_products, dependent: :destroy
  has_many :discounts, through: :discount_products

  belongs_to :order_detail, required: false
  belongs_to :category, required: false

  mount_uploader :image, ImageUploader

  validates :name, presence: true,length: {maximum: 100}
  validates :price, presence: true
  validates :category, presence: true
  validates :classify, presence: true

  enum classify_types: [:Food, :Drink]

  scope :order_by_time, -> {order created_at: :desc}
  scope :order_by_name, -> {order name: :desc}
end
