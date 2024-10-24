# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20241023073552) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["admin_id"], :name => "index_categories_on_admin_id"

  create_table "categorizations", :force => true do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["product_id"], :name => "index_categorizations_on_product_id"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_images", ["imageable_id", "imageable_type"], :name => "index_product_images_on_imageable_id_and_imageable_type"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["admin_id"], :name => "index_products_on_admin_id"

  create_table "purchases", :force => true do |t|
    t.integer  "product_id"
    t.integer  "customer_id"
    t.integer  "quantity"
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["customer_id"], :name => "index_purchases_on_customer_id"
  add_index "purchases", ["product_id"], :name => "index_purchases_on_product_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
