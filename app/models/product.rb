class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :order_details

  belongs_to :category, required: false

  mount_uploader :image, ImageUploader

  validates :name, presence: true,length: {maximum: 100}
  validates :price, presence: true
  validates :category, presence: true
  validates :classify, presence: true

  enum classify_types: [:Food, :Drink]

  scope :order_by_time, -> {order created_at: :desc}
  scope :order_by, -> (filter, direction) {order filter + " " + direction}
  scope :order_by_rate, -> (direction){
    joins(:ratings)
    .group("products.id")
    .order("avg(ratings.vote) #{direction}")
}
end
