class CreateQuotes < ActiveRecord::Migration[7.1]
  def change
    create_table :quotes do |t|
      t.string :status, default: "Non envoyé"

      t.timestamps
    end
  end
end
