Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  delete '/:shopping_cart_id/products/:cart_product_id', to: 'cart_products#destroy'

  get '/order_history', to: 'orders#index', as: 'order_history_path'

end
