class CreateProductCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :product_categories do |t|
      t.string :title
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
