Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  post '/shopping_carts/:shopping_cart_id/cart_products/:cart_product_id', to: 'cart_products#create'
  delete '/shopping_carts/:shopping_cart_id/cart_products/:cart_product_id', to: 'cart_products#destroy'
  get '/users/:user_id/orders', to: 'orders#index', as: 'order_history_path'
  post 'users/:user_id/orders', to: 'orders#create'

end
