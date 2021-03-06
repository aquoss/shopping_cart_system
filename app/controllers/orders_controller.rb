class OrdersController < ApplicationController

  def index
    orders = Order.where(user_id: params[:user_id])
    if !orders.empty?
      orders = format_json(orders)
    end
    render json: orders
  end

  def create
    order = Order.new(order_params)
    if order_saved?(order)
      render json: order, status: :created
    else
      render status: :conflict
    end
  end

  def order_saved?(order)
    shopping_cart = ShoppingCart.find_by(user_id: order.user_id)
    cart_products = CartProduct.where(shopping_cart_id: shopping_cart.id)
    if enough_inventory?(cart_products) && !cart_products.empty?
      order.save
      create_ordered_products(cart_products)
      reset_shopping_cart(shopping_cart)
      return true
    end
    false
  end

  def format_json(orders)
    order_history = []
    orders.each do |order|
      order_data = {
        order_number: order.id,
        number_of_items: order.number_of_items,
        total_price: order.total_price,
        date_purchased: order.created_at,
      }
      products = format_products_json(order)
      order_data[:products] = products
      order_history << order_data
    end
    order_history
  end

  def format_products_json(order)
    products = []
    order.ordered_products.each do |ordered_product|
      product_data = {
        title: ordered_product.product.style.title,
        size: ordered_product.size,
        quantity: ordered_product.quantity,
        attributes: {
          color: ordered_product.product.color,
          material: ordered_product.product.material,
          print: ordered_product.product.print,
        }
      }
      products << product_data
    end
    products
  end

  def enough_inventory?(cart_products)
    cart_products.each do |cart_product|
      inventory = Inventory.find_by(product_id: cart_product.product_id, size: cart_product.size)
      if (inventory.available_inventory < cart_product.quantity)
        return false
      end
    end
    true
  end

  def create_ordered_products(cart_products)
    cart_products.each do |cart_product|
      ordered_product = OrderedProduct.create(order_id: Order.last.id, product_id: cart_product.product_id, size: cart_product.size, quantity: cart_product.quantity)
      update_inventory(ordered_product)
      cart_product.destroy
    end
  end

  def update_inventory(ordered_product)
    inventory = Inventory.find_by(product_id: ordered_product.product_id, size: ordered_product.size)
    inventory.available_inventory -= ordered_product.quantity
    inventory.save
  end

  def reset_shopping_cart(shopping_cart)
    shopping_cart.total_price = 0.00
    shopping_cart.number_of_items = 0
    shopping_cart.save
  end

  private
  def order_params
    params.permit(:user_id, :total_price, :number_of_items)
  end

end
