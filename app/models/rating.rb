class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :vote, presence: true
  enum vote: {"one_star": 1, "two_star": 2, "three_star": 3,
   "four_star": 4, "five_star": 5}
end
