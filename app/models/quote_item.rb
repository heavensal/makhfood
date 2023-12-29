class QuoteItem < ApplicationRecord
  belongs_to :quote
  belongs_to :product

  validates :product_id, uniqueness: { scope: :quote_id,
    message: "ne peut être ajouté plusieurs fois au même devis" }
end
