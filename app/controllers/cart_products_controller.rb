class CartProductsController < ApplicationController

  def create
    cart_product = CartProduct.new(cart_product_params)
    if enough_inventory?(cart_product)
      render json: cart_product, status: :created
    else
      render json: {error: "There is not enough available inventory"}
    end
  end

  def destroy
    cart_product = CartProduct.find(params[:cart_product_id])
    shopping_cart = ShoppingCart.find(params[:shopping_cart_id])
    decrease_shopping_cart(shopping_cart, cart_product)
    deleted_cart_product = cart_product.destroy
    render json: deleted_cart_product
  end

  def enough_inventory?(cart_product)
    shopping_cart = ShoppingCart.find(cart_product.shopping_cart_id)
    inventory = Inventory.find_by(product_id: cart_product.product_id, size: cart_product.size)
    if !inventory.nil? && (inventory.available_inventory >= cart_product.quantity)
      cart_product.save
      increase_shopping_cart(shopping_cart, cart_product)
      return true
    end
    false
  end

  def increase_shopping_cart(shopping_cart, cart_product)
    shopping_cart.number_of_items += cart_product.quantity
    shopping_cart.total_price += (cart_product.product.price * cart_product.quantity)
    shopping_cart.save
  end

  def decrease_shopping_cart(shopping_cart, cart_product)
    shopping_cart.number_of_items -= cart_product.quantity
    shopping_cart.total_price -= (cart_product.product.price * cart_product.quantity)
    shopping_cart.save
  end

  private
  def cart_product_params
    params.permit(:shopping_cart_id, :product_id, :size, :quantity)
  end

end
