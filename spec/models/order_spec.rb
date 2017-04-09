require 'rails_helper'

RSpec.describe Order, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  let(:user) { User.create(first_name: "Amber") }
  it "can load and save" do
    Order.create(user_id: user.id, number_of_products: 2, total_price: 75.00)
    expect(Order.count).to eq 1
  end
end
