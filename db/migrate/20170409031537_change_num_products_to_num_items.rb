class ChangeNumProductsToNumItems < ActiveRecord::Migration[5.0]
  def change
    rename_column :shopping_carts, :number_of_products, :number_of_items
    rename_column :orders, :number_of_products, :number_of_items
  end
end
