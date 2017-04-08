class CreateStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.string :title
      t.string :department
      t.string :class
      t.string :business_group
      t.text :description

      t.timestamps
    end
  end
end
