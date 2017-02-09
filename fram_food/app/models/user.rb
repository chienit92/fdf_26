class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_one :bank_account
end
