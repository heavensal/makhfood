class Quote < ApplicationRecord
  has_many :quote_items, dependent: :destroy
  has_many :products, through: :quote_items

  validates :phone, format: { with: /\A0[1-9](\d{2}){4}\z/, message: "doit être un numéro de téléphone français valide composé uniquement de chiffres" }

end
