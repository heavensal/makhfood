class ChangeColumnEanToProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :ean, :bigint
  end
end
