class AddDefaultValuesToQuotes < ActiveRecord::Migration[7.1]
  def change
    change_column_default :quotes, :first_name, "A définir"
    change_column_default :quotes, :last_name, "A définir"
    change_column_default :quotes, :phone, "A définir"
    change_column_default :quotes, :address, "A définir"
    change_column_default :quotes, :company, "A définir"
  end
end
