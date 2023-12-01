class AddColumnLinkToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :link, :string
  end
end
