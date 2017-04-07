class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.belongs_to :style, foreign_key: true
      t.string :color
      t.string :print
      t.string :material
      t.decimal :price

      t.timestamps
    end
  end
end
