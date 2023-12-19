class AddLinksToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :link, :text
  end
end
