class ProductCategory < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
