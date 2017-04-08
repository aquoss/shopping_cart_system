class CreateShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_carts do |t|
      t.integer :number_of_products
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
