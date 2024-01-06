class AddColumnEmailToQuote < ActiveRecord::Migration[7.1]
  def change
    add_column :quotes, :email, :string
  end
end
