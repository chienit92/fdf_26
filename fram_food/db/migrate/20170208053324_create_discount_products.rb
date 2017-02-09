class CreateDiscountProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :discount_products do |t|
      t.integer :id_discount
      t.integer :id_product

      t.timestamps
    end
  end
end
