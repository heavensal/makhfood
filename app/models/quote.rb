class Quote < ApplicationRecord
  has_many :quote_items, dependent: :destroy
  has_many :products, through: :quote_items

  validates :phone, format: { with: /\A0[1-9]\d{8}\z/ , message: ": Le numéro de téléphone doit être français et valide, composé uniquement de  10 chiffres" }
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: "doit être de type exemple@email.fr" }


end
