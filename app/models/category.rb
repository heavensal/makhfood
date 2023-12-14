class Category < ApplicationRecord
  has_many :products
  has_many :brands, -> { distinct.order(:id) }, through: :products
end
