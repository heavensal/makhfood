class ModifyColumnsInQuotes < ActiveRecord::Migration[7.1]
  def change
    change_column_default :quotes, :email, 'exemple@gmail.com'
    change_column_default :quotes, :phone, '0601020304'
  end
end
