class Product < ApplicationRecord
  has_one_attached :photo
  belongs_to :category
  belongs_to :brand

  has_many :quote_items
  has_many :quotes, through: :quote_items

  def self.ransackable_associations(auth_object = nil)
    %w[brand category]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_scopes(auth_object = nil)
    %w[search_by_category_name]
  end

  def self.search_by_category_name(query)
    joins(:category).where("categories.name ILIKE ?", "%#{query}%")
  end
end
