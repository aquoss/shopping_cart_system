require 'rails_helper'

RSpec.describe "OrderHistory", type: :request do
  before do
    @user = User.create(first_name: "Amber")
    style1 = Style.create(title:"The Cotton Crew")
    @product1 = Product.create(style_id: style1.id, color: "red", material: "cotton", print: "heathered", price: 25.00)
    style2 = Style.create(title:"The Sport Dress")
    @product2 = Product.create(style_id: style2.id, color: "blue", material: "polyester", print: "solid", price: 30.00)
  end

  describe "GET 'users/:user_id/orders'" do
    it "returns an empty array when there are no past orders" do
      get "/users/#{@user.id}/orders"
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)).to eq []
    end

    let(:order) { Order.create(user: @user, number_of_items: 3, total_price: 80.00) }
    let(:ordered_product1) { OrderedProduct.create(product_id: @product1.id, order_id: order.id, quantity: 2, size: "M") }
    let(:ordered_product2) { OrderedProduct.create(product_id: @product2.id, order_id: order.id, quantity: 1, size: "S") }
    it "returns a user's order history" do
      get "/users/#{order.user_id}/orders"
      expect(response.status).to eq 200
      order_history = JSON.parse(response.body)
      expect(order_history[0]["order_number"]).to be_present
      expect(order_history[0]["number_of_items"]).to eq 3
      expect(order_history[0]["total_price"]).to eq "80.0"
      expect(order_history[0]["date_purchased"].to_time.to_s).to eq order.created_at.to_time.to_s

      expect(order_history[0]["products"][0]["title"]).to eq "The Cotton Crew"
      expect(order_history[0]["products"][0]["size"]).to eq "M"
      expect(order_history[0]["products"][0]["quantity"]).to eq 2
      expect(order_history[0]["products"][0]["price"]).to eq 25.00.to_s
      expect(order_history[0]["products"][0]["attributes"]["color"]).to eq "red"
      expect(order_history[0]["products"][0]["attributes"]["print"]).to eq "heathered"
      expect(order_history[0]["products"][0]["attributes"]["material"]).to eq "cotton"

      expect(order_history[0]["products"][1]["title"]).to eq "The Sport Dress"
      expect(order_history[0]["products"][1]["size"]).to eq "S"
      expect(order_history[0]["products"][1]["quantity"]).to eq 1
      expect(order_history[0]["products"][1]["price"]).to eq 30.00.to_s
      expect(order_history[0]["products"][1]["attributes"]["color"]).to eq "blue"
      expect(order_history[0]["products"][1]["attributes"]["print"]).to eq "solid"
      expect(order_history[0]["products"][1]["attributes"]["material"]).to eq "polyester"
    end

  end
end
