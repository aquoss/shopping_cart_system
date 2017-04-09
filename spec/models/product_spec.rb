require 'rails_helper'

RSpec.describe Product, type: :model do
  context "associations" do
    it { should belong_to(:style) }
    it { should have_many(:cart_products) }
    it { should have_many(:ordered_products) }
    it { should have_many(:shopping_carts) }
    it { should have_many(:orders) }
    it { should have_many(:inventories) }
  end

  let(:style) { Style.create(title:"The Cotton Crew", department:"Tops", style_class:"Shirts", business_group:"Womens") }
  it "can load and save" do
    Product.create(style_id: style.id, color: "red")
    expect(Product.count).to eq 1
  end
end
