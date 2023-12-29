class AddUniqueConstraintToQuoteItems < ActiveRecord::Migration[7.1]
  def change
    add_index :quote_items, [:product_id, :quote_id], unique: true
  end
end
