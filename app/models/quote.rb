class Quote < ApplicationRecord
  has_many :quote_items, dependent: :destroy
  has_many :products, through: :quote_items

end
