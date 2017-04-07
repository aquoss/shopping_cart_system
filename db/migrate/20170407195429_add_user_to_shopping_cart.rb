class AddUserToShoppingCart < ActiveRecord::Migration[5.0]
  def change
    add_column :shopping_carts, :user_id, :integer
  end
end
