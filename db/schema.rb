# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170407202246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_products", force: :cascade do |t|
    t.integer  "shopping_cart_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.string   "size"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["product_id"], name: "index_cart_products_on_product_id", using: :btree
    t.index ["shopping_cart_id"], name: "index_cart_products_on_shopping_cart_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "size"
    t.integer  "available_inventory"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["product_id"], name: "index_inventories_on_product_id", using: :btree
  end

  create_table "ordered_products", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_ordered_products_on_order_id", using: :btree
    t.index ["product_id"], name: "index_ordered_products_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.decimal  "total_price",        precision: 8, scale: 2
    t.integer  "number_of_products"
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.integer  "style_id"
    t.string   "color"
    t.string   "print"
    t.string   "material"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["style_id"], name: "index_products_on_style_id", using: :btree
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "number_of_products"
    t.decimal  "total_price",        precision: 8, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string   "title"
    t.string   "department"
    t.string   "class"
    t.string   "business_group"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "shopping_cart_id"
  end

  add_foreign_key "cart_products", "products"
  add_foreign_key "cart_products", "shopping_carts"
  add_foreign_key "inventories", "products"
  add_foreign_key "ordered_products", "orders"
  add_foreign_key "ordered_products", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "styles"
end
