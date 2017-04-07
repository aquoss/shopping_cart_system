class ShoppingCart < ApplicationRecord
  has_one :user
  has_many :cart_products
  has_many :products, through: :cart_products
end
