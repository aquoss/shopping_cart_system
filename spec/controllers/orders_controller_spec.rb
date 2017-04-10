require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before :each do
    @user = User.create(first_name: "Amber")
    @shopping_cart = ShoppingCart.create(user_id: @user.id, number_of_items: 2, total_price: 75.00)
    style = Style.create(title:"The Cotton Crew")
    @product = Product.create(style_id: style.id, color: "red", price: 37.50)
    @cart_product = CartProduct.create(product_id: @product.id, shopping_cart_id: @shopping_cart.id, quantity: 2, size: "M")
    @inventory = Inventory.create(product_id: @product.id, available_inventory: 20, size: "M")
  end

  describe "POST#create" do
    context "with enough available inventory" do
      it "creates a new order" do
        expect do
          post :create, { user_id: @user.id, number_of_items: @shopping_cart.number_of_items, total_price: @shopping_cart.total_price }
        end.to change { Order.count }.by 1

        expect(Order.last.user_id).to eq @user.id
        expect(Order.last.number_of_items).to eq 2
        expect(Order.last.total_price).to eq 75.00
      end

      it "returns 201 and renders the order attributes" do
        post :create, { user_id: @user.id, number_of_items: @shopping_cart.number_of_items, total_price: @shopping_cart.total_price }
        expect(response.status).to eq 201

        response_json = JSON.parse(response.body)
        expect(response_json["id"]).to be_present
        expect(response_json["user_id"]).to eq @user.id
        expect(response_json["number_of_items"]).to eq 2
        expect(response_json["total_price"]).to eq "75.0"
      end

      it "creates one ordered product per product" do
        post :create, { user_id: @user.id, number_of_items: @shopping_cart.number_of_items, total_price: @shopping_cart.total_price }
        expect(Order.last.products.count).to eq 1
      end

      it "updates the available inventory" do
        expect do
          post :create, { user_id: @user.id, number_of_items: @shopping_cart.number_of_items, total_price: @shopping_cart.total_price }
        end.to change { @inventory.available_inventory }.by -2
      end

      it "destroys the cart products and resets the shopping cart" do
        post :create, { user_id: @user.id, number_of_items: @shopping_cart.number_of_items, total_price: @shopping_cart.total_price }
        expect(@shopping_cart.products.count).to eq 0
        expect(@shopping_cart.number_of_items).to eq 0
        expect(@shopping_cart.total_price).to eq 0
      end
    end

    context "with not enough available inventory" do
      it "returns 409 and does not save the new order" do
        expect do
          post :create, { user_id: @user.id, number_of_items: @shopping_cart.number_of_items, total_price: @shopping_cart.total_price }
        end.to change { Order.count }.by 0

        expect(response.status).to eq 409
      end
    end
  end
end
