require 'rails_helper'

RSpec.describe OrderedProduct, type: :model do
  context "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  let(:user) { User.create(first_name: "Amber") }
  let(:order) { Order.create(user_id: user.id, number_of_products: 2, total_price: 75.00) }
  let(:style) { Style.create(title: "Cotton Crew") }
  let(:product) { Product.create(style_id: style.id, color: "red") }
  it "can load and save" do
    OrderedProduct.create(order_id: order.id, product_id: product.id)
    expect(OrderedProduct.count).to eq 1
  end
end
