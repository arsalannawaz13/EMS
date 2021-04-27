class Product < ApplicationRecord
  belongs_to :product_category
  has_one_attached :product_image
  has_many :order_items

  STATUS = %w( publish draft pending ).freeze
  validates :status, presence: true, inclusion: { in: STATUS }
end
