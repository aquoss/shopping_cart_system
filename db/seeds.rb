# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
user = User.create(first_name: "John", last_name: "Doe", email: "john@gmail.com")
shopping_cart = ShoppingCart.create(user_id: user.id, number_of_items: 0, total_price: 0.00)

style1 = Style.create(title:"The Cotton Crew", department: "Apparel", style_class: "Tops", business_group: "Womens", description: "An every-day tee with a rounded neck")
product1 = Product.create(style_id: style1.id, color: "red", material: "cotton", print: "heathered", price: 25.00)
Inventory.create(product_id: product1.id, size: "S", available_inventory: 30)
Inventory.create(product_id: product1.id, size: "M", available_inventory: 20)
Inventory.create(product_id: product1.id, size: "L", available_inventory: 1)

style2 = Style.create(title:"The Sport Dress", department: "Apparel", style_class: "Dresses", business_group: "Womens", description: "A sleek and comfy dress")
product2 = Product.create(style_id: style2.id, color: "blue", material: "polyester", print: "solid", price: 30.00)
Inventory.create(product_id: product2.id, size: "S", available_inventory: 15)
Inventory.create(product_id: product2.id, size: "M", available_inventory: 5)
Inventory.create(product_id: product2.id, size: "L", available_inventory: 10)
