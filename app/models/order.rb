class Order < ApplicationRecord
  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy

  belongs_to :user

  before_create :init_order
  before_save :update_subtotal

  enum status: [:inprogress, :rejected, :approved]
  def subtotal
    order_details.collect {|od| od.valid? ? (od.unit_quantity * od.unit_price) : 0}.sum
  end

  private
  def init_order
    self.status = 0
    self.total_pay = 0
  end

  def update_subtotal
    self[:total_pay] = subtotal
  end
end
