require 'rails_helper'

RSpec.describe "OrderHistory", type: :request do
  before do
    user = User.create(first_name: "Amber")
    @order = Order.create(user_id: user.id, number_of_items: 3, total_price: 80.00)

    style1 = Style.create(title:"The Cotton Crew")
    @product1 = Product.create(style_id: style1.id, color: "red", material: "cotton", print: "heathered", price: 25.00)
    @ordered_product1 = OrderedProduct.create(product_id: @product1.id, order_id: @order.id, quantity: 2, size: "M")

    style2 = Style.create(title:"The Sport Dress")
    @product2 = Product.create(style_id: style2.id, color: "blue", material: "polyester", print: "solid", price: 30.00)
    @ordered_product2 = OrderedProduct.create(product_id: @product2.id, order_id: @order.id, quantity: 1, size: "S")
  end

  describe "GET 'users/:user_id/orders'" do
    it "returns an empty array when there are no past orders" do
      get "/users/#{@order.user_id}/orders"
      expect(response.status).to eq 200
      expect(JSON[response.body]).to eq []
    end

    it "returns a user's order history" do
      get "/users/#{@order.user_id}/orders"
      expect(response.status).to eq 200
      order_history = JSON[response.body]
      expect(order_history.count).to eq 1
      expect(order_history[0]["order_number"]).to be present
      expect(order_history[0]["number_of_items"]).to eq 3
      expect(order_history[0]["total_price"]).to eq 80.00
      expect(order_history[0]["date_purchased"]).to eq @order.created_at

      expect(order_history[0]["products"][0]["title"]).to eq "The Cotton Crew"
      expect(order_history[0]["products"][0]["size"]).to eq "M"
      expect(order_history[0]["products"][0]["quantity"]).to eq 2
      expect(order_history[0]["products"][0]["price"]).to eq 25.00
      expect(order_history[0]["products"][0]["attributes"]["color"]).to eq "red"
      expect(order_history[0]["products"][0]["attributes"]["print"]).to eq "heathered"
      expect(order_history[0]["products"][0]["attributes"]["material"]).to eq "cotton"

      expect(order_history[0]["products"][0]["title"]).to eq "The Sport Dress"
      expect(order_history[0]["products"][0]["size"]).to eq "S"
      expect(order_history[0]["products"][0]["quantity"]).to eq 1
      expect(order_history[0]["products"][0]["price"]).to eq 30.00
      expect(order_history[0]["products"][0]["attributes"]["color"]).to eq "blue"
      expect(order_history[0]["products"][0]["attributes"]["print"]).to eq "solid"
      expect(order_history[0]["products"][0]["attributes"]["material"]).to eq "polyester"
    end

  end
end
