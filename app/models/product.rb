class Product < ApplicationRecord
  belongs_to :style
  has_many :cart_products
  has_many :ordered_products
  has_many :shopping_carts, through: :cart_products
  has_many :orders, through: :ordered_products
  has_many :inventories
end
