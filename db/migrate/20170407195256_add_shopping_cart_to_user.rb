class AddShoppingCartToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :shopping_cart_id, :integer
  end
end
