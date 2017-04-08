class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.belongs_to :product, foreign_key: true
      t.string :size
      t.integer :available_inventory

      t.timestamps
    end
  end
end
