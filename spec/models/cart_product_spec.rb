require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  context "associations" do
    it { should belong_to(:product) }
    it { should belong_to(:shopping_cart) }
  end

  let(:user) { User.create(first_name: "Amber") }
  let(:shopping_cart) { ShoppingCart.create(user_id: user.id, total_price: 75.00, number_of_products: 2) }
  let(:style) { Style.create(title: "Cotton Crew") }
  let(:product) { Product.create(style_id: style.id, color: "red") }
  it "can load and save" do
    CartProduct.create(product_id: product.id, shopping_cart_id: shopping_cart.id, quantity: 1)
    expect(CartProduct.count).to eq 1
  end
end
