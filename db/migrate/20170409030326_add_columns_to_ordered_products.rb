class AddColumnsToOrderedProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :ordered_products, :quantity, :integer
    add_column :ordered_products, :size, :string
  end
end
