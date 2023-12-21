class AddColumnsToQuotes < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :first_name, :string
    add_column :quotes, :last_name, :string
    add_column :quotes, :phone, :string
    add_column :quotes, :address, :string
    add_column :quotes, :company, :string
  end
end
