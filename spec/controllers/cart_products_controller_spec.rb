require 'rails_helper'

RSpec.describe CartProductsController, type: :controller do
  before :each do
    user = User.create(first_name: "Amber")
    @shopping_cart = ShoppingCart.create(user_id: user.id, number_of_items: 0)
    style = Style.create(title:"The Cotton Crew")
    @product = Product.create(style: style.id, color: "red", price: 35.00)
  end

  describe "POST#create" do
    it "creates a new product for a cart" do
      expect do
        post :create, { product_id: @product.id, shopping_cart_id: @shopping_cart.id, quantity: 2, size: "M" }
      end.to change { CartProduct.count }.by 1

      expect(CartProduct.last.product_id).to eq @product.id
      expect(CartProduct.last.shopping_cart_id).to eq @shopping_cart.id
      expect(CartProduct.last.quantity).to eq 2
      expect(CartProduct.last.size).to eq "M"
    end

    it "returns 201 and renders the new product cart association" do
      post :create, { product_id: @product.id, shopping_cart_id: @shopping_cart.id, quantity: 2, size: "M" }
      expect(response.status).to eq 201

      response_jso = JSON.parse(response.body)
      expect(response_json["id"]).to be_present
      expect(response_json["product_id"]).to eq @product.id
      expect(response_json["shopping_cart_id"]).to eq @shopping_cart.id
      expect(response_json["quantity"]).to eq 2
      expect(response_json["size"]).to eq "M"
    end

    it "updates the shopping cart attributes" do
      post :create, { product_id: @product.id, shopping_cart_id: @shopping_cart.id, quantity: 2, size: "M" }
      expect(@shopping_cart.number_of_items).to change by 2
      expect(@shopping_cart.total_price).to change by(@product.price * 2)
    end
  end

  describe "DELETE#destroy" do
    let(:cart_product) { CartProduct.create(product_id: @product.id, shopping_cart_id: @shopping_cart.id, quantity: 2, size: "M") }

    it "deletes a product from the cart" do
      expect {
        delete :destroy, { shopping_cart_id: @shopping_cart, cart_product_id: cart_product.id }
      }.to change { CartProduct.count }.by(0)
    end

    it "returns 200 and renders the deleted product cart association" do
      delete :destroy, { shopping_cart_id: @shopping_cart, cart_product_id: cart_product.id }
      expect(response.status).to eq 200

      response_json = JSON.parse(response.body)
      expect(response_json["id"]).to eq cart_product.id
      expect(response_json["shopping_cart_id"]).to eq @shopping_cart.id
      expect(response_json["product_id"]).to eq @product.id
      expect(response_json["quantity"]).to eq 2
      expect(response_json["size"]).to eq "M"
    end

    it "updates the shopping cart attributes" do
      delete :destroy, { shopping_cart_id: @shopping_cart, cart_product_id: cart_product.id }
      expect(@shopping_cart.number_of_items).to change by -2
      expect(@shopping_cart.total_price).to change by(-@product.price * 2)
    end

  end

end
