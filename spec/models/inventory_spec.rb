require 'rails_helper'

RSpec.describe Inventory, type: :model do
  context "associations" do
    it { should belong_to(:product) }
  end

  let(:style) { Style.create(title: "Cotton Crew") }
  let(:product) { Product.create(style_id: style.id, color: "red") }
  it "can load and save" do
    Inventory.create(product_id: product.id, available_inventory: 200)
    expect(Inventory.count).to eq 1
  end
end
