class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.integer :ean
      t.decimal :unit_price
      t.string :unit
      t.text :box
      t.decimal :price_per_unit
      t.decimal :tva
      t.string :mesure_unit
      t.decimal :ht_box_price
      t.decimal :ttc_box_price
      t.text :description
      t.text :specification
      t.text :conditionning

      t.timestamps
    end
  end
end
