class CartProductsController < ApplicationController

  def create
    cart_product = CartProduct.new(cart_product_params)
    shopping_cart = ShoppingCart.find(cart_product.shopping_cart_id)
    inventory = Inventory.where('product_id = ? && size = ?', cart_product.product_id, cart_product.size)
    if (inventory.available_inventory >= cart_product.quantity)
      cart_product.save
      shopping_cart.number_of_items += cart_product.quantity
      shopping_cart.total_price += (cart_product.price * cart_product.quantity)
      render json: cart_product, status: :created
    end
  end

  def destory
    cart_product = CartProduct.find(params[:cart_product_id])
    deleted_cart_product = cart_product.destroy
    shopping_cart = ShoppingCart.find(deleted_cart_product.shopping_cart_id)
    shopping_cart.number_of_items -= deleted_cart_product.quantity
    shopping_cart.total_price -= (deleted_cart_product.price * deleted_cart_product.quantity)
    render json: deleted_cart_product
  end


  private
  def cart_product_params
    params.permit(:shopping_cart_id, :product_id, :size, :quantity)
  end

end

### require the parameters in the model (might have to update tests)
