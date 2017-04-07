class AddNumberOfProductsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :number_of_products, :integer
  end
end
