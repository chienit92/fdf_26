class Order < ApplicationRecord
  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy

  belongs_to :user

  before_create :init_order
  before_save :update_subtotal

  enum status: [:inprogress, :rejected, :approved]
  def subtotal
    order_details.collect {|od| od.valid? ? (od.unit_quantity * od.unit_price) : Settings.zero}.sum
  end

  private
  def init_order
    self.status = Settings.zero
    self.total_pay = Settings.zero
  end

  def update_subtotal
    self[:total_pay] = subtotal
  end
end
