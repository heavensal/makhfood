class AddColumnToProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :brand, foreign_key: true
    add_reference :products, :category, foreign_key: true
  end
end
