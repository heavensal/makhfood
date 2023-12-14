class Brand < ApplicationRecord
  has_many :products
  has_many :categories, through: :products

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
