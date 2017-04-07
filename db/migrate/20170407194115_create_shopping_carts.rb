class CreateShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_carts do |t|
      t.integer :quantity
      t.string :size

      t.timestamps
    end
  end
end
