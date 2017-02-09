class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :description
      t.float :value
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end
