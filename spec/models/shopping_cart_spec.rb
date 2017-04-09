require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:cart_products) }
    it { should have_many(:products) }
  end

  let(:user) { User.create(first_name: "Amber") }
  it "can load and save" do
    ShoppingCart.create(user_id: user.id, total_price: 75.00, number_of_items: 2)
    expect(ShoppingCart.count).to eq 1
  end
end
