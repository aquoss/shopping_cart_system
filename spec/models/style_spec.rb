require 'rails_helper'

RSpec.describe Style, type: :model do
  context "associations" do
    it { should have_many(:products) }
  end

  it "can load and save" do
    Style.create(title:"The Cotton Crew", department:"Tops", style_class:"Shirts", business_group:"Womens")
    expect(Style.count).to eq 1
  end
end
