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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140701023831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allergens", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description", default: "No Description"
  end

  create_table "allergens_ingredients", id: false, force: true do |t|
    t.integer "allergen_id",   null: false
    t.integer "ingredient_id", null: false
  end

  add_index "allergens_ingredients", ["allergen_id"], name: "index_allergens_ingredients_on_allergen_id", using: :btree
  add_index "allergens_ingredients", ["ingredient_id"], name: "index_allergens_ingredients_on_ingredient_id", using: :btree

  create_table "allergens_patient_groups", id: false, force: true do |t|
    t.integer "allergen_id",      null: false
    t.integer "patient_group_id", null: false
  end

  add_index "allergens_patient_groups", ["allergen_id"], name: "index_allergens_patient_groups_on_allergen_id", using: :btree
  add_index "allergens_patient_groups", ["patient_group_id"], name: "index_allergens_patient_groups_on_patient_group_id", using: :btree

  create_table "appointments", force: true do |t|
    t.integer  "patient_focus_id"
    t.integer  "appointment_host_id"
    t.integer  "dietitian_id"
    t.datetime "date"
    t.integer  "room_id"
    t.text     "note"
    t.text     "client_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characteristics", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characteristics_recipes", force: true do |t|
    t.integer "recipe_id"
    t.integer "characteristic_id"
  end

  add_index "characteristics_recipes", ["characteristic_id"], name: "index_characteristics_recipes_on_characteristic_id", using: :btree
  add_index "characteristics_recipes", ["recipe_id"], name: "index_characteristics_recipes_on_recipe_id", using: :btree

  create_table "dietitians", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dietitians", ["email"], name: "index_dietitians_on_email", unique: true, using: :btree
  add_index "dietitians", ["reset_password_token"], name: "index_dietitians_on_reset_password_token", unique: true, using: :btree

  create_table "families", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "head_of_family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["head_of_family_id"], name: "index_families_on_head_of_family_id", using: :btree

  create_table "families_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "family_id"
  end

  add_index "families_users", ["family_id"], name: "index_families_users_on_family_id", using: :btree
  add_index "families_users", ["user_id"], name: "index_families_users_on_user_id", using: :btree

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients_recipe_steps", id: false, force: true do |t|
    t.integer "ingredient_id",  null: false
    t.integer "recipe_step_id", null: false
  end

  add_index "ingredients_recipe_steps", ["ingredient_id"], name: "index_ingredients_recipe_steps_on_ingredient_id", using: :btree
  add_index "ingredients_recipe_steps", ["recipe_step_id"], name: "index_ingredients_recipe_steps_on_recipe_step_id", using: :btree

  create_table "ingredients_recipes", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amount_unit"
  end

  add_index "ingredients_recipes", ["ingredient_id"], name: "index_ingredients_recipes_on_ingredient_id", using: :btree
  add_index "ingredients_recipes", ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id", using: :btree

  create_table "patient_groups", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.integer  "order"
    t.boolean  "input_option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_groups_recipes", id: false, force: true do |t|
    t.integer "recipe_id"
    t.integer "patient_group_id"
  end

  create_table "patient_groups_users", id: false, force: true do |t|
    t.integer "patient_group_id", null: false
    t.integer "user_id",          null: false
  end

  create_table "recipe_steps", force: true do |t|
    t.integer  "step_number"
    t.text     "directions"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipe_steps", ["recipe_id"], name: "index_recipe_steps_on_recipe_id", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.integer  "dietitian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "inspiration"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
