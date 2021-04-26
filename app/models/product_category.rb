class ProductCategory < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :products
end
