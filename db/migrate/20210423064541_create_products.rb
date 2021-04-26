class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.string :status
      t.references :product_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
