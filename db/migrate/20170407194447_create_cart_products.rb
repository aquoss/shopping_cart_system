class CreateCartProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_products do |t|
      t.belongs_to :shopping_cart, foreign_key: true
      t.belongs_to :product, foreign_key: true
      t.integer :quantity
      t.string :size

      t.timestamps
    end
  end
end
