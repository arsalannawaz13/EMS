class Order < ApplicationRecord
  has_many :order_items, dependent: :delete_all
  belongs_to :user
  
  before_save :set_subtotal

  PAYMENT = %w( Cash-On-Delivery Check ).freeze
  validates :payment_method, presence: true, inclusion: { in: PAYMENT }

  enum status: {
    pending: 0,
    confirmed: 1
  }

  def subtotal
    order_items.collect{|order_item| order_item.valid? ? order_item.unit_price * order_item.quantity : 0}.sum
  end

  private

  def set_subtotal
    self[:subtotal] = subtotal
  end
end
