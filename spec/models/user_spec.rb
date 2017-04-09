require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_many(:orders) }
    it { should have_one(:shopping_cart) }
  end

  it "can load and save" do
    User.create(first_name:"Amber")
    expect(User.count).to eq 1
  end

end
