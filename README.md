# Shopping Cart System

## Database Structure
![erd](erd.jpg)
#### Reasoning
- Separated Shopping Cart from User  
  - Can see when the shopping cart was last updated, without the user profile also showing as updated  
- Separated Products from Styles  
  - In merchandising, one style is often reordered but with updated attributes (such as color, print, material). Depending on the changes, this can also alter the price. This is why price and specific style attributes are recorded under Product, while the overall style name and business specifics are recorded under Style.  
- Metrics measured in Style table (using Everlane as an example)  
  - department: apparel, accessories
  - class: tees, shirts, sweaters, dresses, bottoms, outerwear, leisure, shoes, leather_bags, backpacks, small_accessories
  - business_group: womens, mens, kids, unisex  
- Made Inventory its own table
  - Depending on the product, sizing can get very long and complicated (i.e. 00 - 16, shoe sizes). Separating inventory saves space on the Product table, and allows the inventory to continually update without affecting the product itself. Also, if a business has more than one warehouse, it is easy scale the Inventory table by adding a "warehouse" column.  
- Connected Orders and Products with a join table
  - When viewing the purchase history, this makes it possible to see not only what products were purchased, but what products were purchased together (extremely useful if recommending products to other customers based on their purchase history).
