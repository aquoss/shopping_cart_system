class ChangeClassToStyleClass < ActiveRecord::Migration[5.0]
  def change
    rename_column :styles, :class, :style_class
  end
end
