class User < ApplicationRecord
  has_secure_token # generates a new auth_token when a user is created
  has_one :cart, dependent: :destroy
  has_many :orders
end
