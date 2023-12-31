class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :categories, through: :products

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
