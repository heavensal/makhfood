class Category < ApplicationRecord
  has_one_attached :photo
  has_many :products
  has_many :brands, -> { distinct.order(:id) }, through: :products

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
