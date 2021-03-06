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

ActiveRecord::Schema.define(version: 20170220233029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: true do |t|
    t.integer  "patient_focus_id"
    t.integer  "appointment_host_id"
    t.integer  "dietitian_id"
    t.integer  "room_id"
    t.text     "note"
    t.text     "client_note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "stripe_card_token"
    t.integer  "regular_price"
    t.integer  "invoice_price"
    t.integer  "duration"
    t.text     "other_note"
    t.integer  "time_slot_id"
    t.string   "status"
    t.integer  "registration_stage",          default: 0
    t.boolean  "client_assessment_sent"
    t.datetime "client_assessment_sent_at"
    t.boolean  "provider_assessment_sent"
    t.datetime "provider_assessment_sent_at"
    t.integer  "user_package_id"
  end

  add_index "appointments", ["time_slot_id"], name: "index_appointments_on_time_slot_id", using: :btree
  add_index "appointments", ["user_package_id"], name: "index_appointments_on_user_package_id", using: :btree

  create_table "articles", force: true do |t|
    t.text     "content"
    t.integer  "dietitian_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "availabilities", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "buffered_start_time"
    t.datetime "buffered_end_time"
    t.integer  "dietitian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "availabilities", ["dietitian_id"], name: "index_availabilities_on_dietitian_id", using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "coupon_redemptions", force: true do |t|
    t.integer  "coupon_id"
    t.integer  "user_id"
    t.integer  "purchase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "coupon_redemptions", ["coupon_id"], name: "index_coupon_redemptions_on_coupon_id", using: :btree
  add_index "coupon_redemptions", ["purchase_id"], name: "index_coupon_redemptions_on_purchase_id", using: :btree
  add_index "coupon_redemptions", ["user_id"], name: "index_coupon_redemptions_on_user_id", using: :btree

  create_table "coupons", force: true do |t|
    t.string   "code"
    t.string   "description"
    t.datetime "valid_from"
    t.datetime "valid_until"
    t.integer  "redemption_limit",          default: 1
    t.integer  "redemptions_count",         default: 0
    t.integer  "amount"
    t.string   "amount_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "redemption_limit_per_user", default: 1
  end

  create_table "dietitians", force: true do |t|
    t.string   "email",                          default: "", null: false
    t.string   "encrypted_password",             default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                  default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "signature"
    t.string   "time_zone"
    t.string   "location"
    t.integer  "experience_level"
    t.integer  "age_level"
    t.string   "undergraduate_education"
    t.string   "graduate_education"
    t.string   "professional_experience_first"
    t.string   "professional_experience_second"
    t.string   "professional_experience_third"
    t.string   "professional_experience_fourth"
    t.string   "professional_experience_fifth"
    t.text     "introduction"
    t.string   "phone_number"
  end

  add_index "dietitians", ["email"], name: "index_dietitians_on_email", unique: true, using: :btree
  add_index "dietitians", ["reset_password_token"], name: "index_dietitians_on_reset_password_token", unique: true, using: :btree

  create_table "dietitians_roles", id: false, force: true do |t|
    t.integer "dietitian_id"
    t.integer "role_id"
  end

  add_index "dietitians_roles", ["dietitian_id", "role_id"], name: "index_dietitians_roles_on_dietitian_id_and_role_id", using: :btree

  create_table "expertises", force: true do |t|
    t.integer  "dietitian_preference"
    t.integer  "dietitian_qualification"
    t.integer  "dietitian_id"
    t.integer  "patient_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expertises", ["dietitian_id"], name: "index_expertises_on_dietitian_id", using: :btree
  add_index "expertises", ["patient_group_id"], name: "index_expertises_on_patient_group_id", using: :btree

  create_table "families", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "head_of_family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "families", ["head_of_family_id"], name: "index_families_on_head_of_family_id", using: :btree

  create_table "food_diaries", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "food_diaries", ["user_id"], name: "index_food_diaries_on_user_id", using: :btree

  create_table "food_diary_entries", force: true do |t|
    t.integer  "food_diary_id"
    t.datetime "consumed_at"
    t.string   "food_item"
    t.string   "location"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "food_diary_entries", ["food_diary_id"], name: "index_food_diary_entries_on_food_diary_id", using: :btree

  create_table "growth_charts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "growth_charts", ["user_id"], name: "index_growth_charts_on_user_id", using: :btree

  create_table "growth_entries", force: true do |t|
    t.integer  "growth_chart_id"
    t.date     "measured_at"
    t.integer  "height_in_inches"
    t.integer  "weight_in_ounces"
    t.string   "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "height_percentile"
    t.string   "height_z_score"
    t.string   "weight_percentile"
    t.string   "weight_z_score"
    t.string   "bmi_percentile"
    t.string   "bmi_z_score"
    t.text     "dietitian_note"
    t.text     "client_note"
    t.string   "energy_requirement"
    t.string   "protein_requirement"
    t.string   "fluids_requirement"
  end

  add_index "growth_entries", ["growth_chart_id"], name: "index_growth_entries_on_growth_chart_id", using: :btree

  create_table "guest_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email_address"
    t.string   "title"
    t.string   "company"
    t.text     "purpose"
    t.text     "help"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "image_type"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "image"
    t.integer  "position",       default: 0
  end

  add_index "images", ["imageable_id", "imageable_type"], name: "index_images_on_imageable_id_and_imageable_type", using: :btree
  add_index "images", ["position"], name: "index_images_on_position", using: :btree

  create_table "member_plans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_id"
    t.integer  "amount"
    t.string   "currency",              default: "usd"
    t.string   "interval"
    t.boolean  "live_mode"
    t.integer  "interval_count"
    t.integer  "trial_period_days"
    t.string   "statement_description"
    t.integer  "plan_id"
  end

  add_index "member_plans", ["plan_id"], name: "index_member_plans_on_plan_id", using: :btree

  create_table "monologue_posts", force: true do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "published_at"
    t.integer  "author_id"
    t.string   "content_type"
    t.boolean  "public"
    t.datetime "target_published_at"
    t.string   "main_image_url"
  end

  add_index "monologue_posts", ["author_id"], name: "index_monologue_posts_on_author_id", using: :btree
  add_index "monologue_posts", ["url"], name: "index_monologue_posts_on_url", unique: true, using: :btree
  add_index "monologue_posts", ["user_id"], name: "index_monologue_posts_on_user_id", using: :btree

  create_table "monologue_taggings", force: true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "monologue_taggings", ["post_id"], name: "index_monologue_taggings_on_post_id", using: :btree
  add_index "monologue_taggings", ["tag_id"], name: "index_monologue_taggings_on_tag_id", using: :btree

  create_table "monologue_tags", force: true do |t|
    t.string  "name"
    t.string  "tag_category"
    t.string  "content_type"
    t.boolean "browseable",        default: true,  null: false
    t.boolean "showcase",          default: false, null: false
    t.integer "showcase_position", default: 0,     null: false
  end

  add_index "monologue_tags", ["name"], name: "index_monologue_tags_on_name", using: :btree

  create_table "monologue_users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.integer  "full_price"
    t.text     "description"
    t.integer  "num_half_appointments"
    t.integer  "num_full_appointments"
    t.integer  "expiration_in_months"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patient_groups", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.integer  "order"
    t.boolean  "input_option", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "unverified",   default: false
    t.boolean  "has_triggers", default: false, null: false
  end

  create_table "patient_groups_users", id: false, force: true do |t|
    t.integer "patient_group_id", null: false
    t.integer "user_id",          null: false
  end

  create_table "plans", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_recommendations", force: true do |t|
    t.integer  "dietitian_id"
    t.integer  "user_id"
    t.text     "message"
    t.integer  "monologue_post_id"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_recommendations", ["appointment_id"], name: "index_post_recommendations_on_appointment_id", using: :btree
  add_index "post_recommendations", ["dietitian_id"], name: "index_post_recommendations_on_dietitian_id", using: :btree
  add_index "post_recommendations", ["monologue_post_id"], name: "index_post_recommendations_on_monologue_post_id", using: :btree
  add_index "post_recommendations", ["user_id"], name: "index_post_recommendations_on_user_id", using: :btree

  create_table "purchases", force: true do |t|
    t.integer  "user_id"
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_card_token"
    t.integer  "invoice_price"
    t.integer  "invoice_cost"
    t.string   "status"
    t.datetime "completed_at"
  end

  add_index "purchases", ["purchasable_id", "purchasable_type"], name: "index_purchases_on_purchasable_id_and_purchasable_type", using: :btree
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "question_type"
    t.text     "content"
    t.integer  "position"
    t.integer  "tier",            default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_group_id"
  end

  add_index "questions", ["survey_group_id"], name: "index_questions_on_survey_group_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.string   "sessionId"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dietitian_id"
  end

  add_index "rooms", ["dietitian_id"], name: "index_rooms_on_dietitian_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                     null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type",   limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "member_plan_id"
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "trial_end"
    t.datetime "trial_start"
    t.datetime "ended_at"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "cancelled_at"
    t.string   "status"
    t.integer  "quantity",             default: 1
    t.integer  "stripe_id"
  end

  add_index "subscriptions", ["member_plan_id"], name: "index_subscriptions_on_member_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "survey_groups", force: true do |t|
    t.string   "name"
    t.integer  "version_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.integer  "surveyable_id"
    t.string   "surveyable_type"
    t.boolean  "completed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_group_id"
    t.datetime "last_updated_at"
    t.datetime "completed_at"
  end

  add_index "surveys", ["survey_group_id"], name: "index_surveys_on_survey_group_id", using: :btree

  create_table "surveys_questions", force: true do |t|
    t.integer  "survey_id"
    t.integer  "question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "surveys_questions", ["question_id"], name: "index_surveys_questions_on_question_id", using: :btree
  add_index "surveys_questions", ["survey_id"], name: "index_surveys_questions_on_survey_id", using: :btree

  create_table "time_slots", force: true do |t|
    t.string   "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "minutes"
    t.string   "status"
    t.integer  "availability_id"
    t.boolean  "vacancy",         default: true
  end

  add_index "time_slots", ["availability_id"], name: "index_time_slots_on_availability_id", using: :btree

  create_table "user_families", force: true do |t|
    t.integer "user_id"
    t.integer "family_id"
  end

  add_index "user_families", ["family_id"], name: "index_user_families_on_family_id", using: :btree
  add_index "user_families", ["user_id"], name: "index_user_families_on_user_id", using: :btree

  create_table "user_packages", force: true do |t|
    t.integer "user_id"
    t.integer "package_id"
    t.date    "purchase_date"
    t.date    "expiration_date"
  end

  add_index "user_packages", ["package_id"], name: "index_user_packages_on_package_id", using: :btree
  add_index "user_packages", ["user_id"], name: "index_user_packages_on_user_id", using: :btree

  create_table "user_roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["name", "resource_type", "resource_id"], name: "index_user_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "user_roles", ["name"], name: "index_user_roles_on_name", using: :btree

  create_table "user_versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.string   "ip_address"
    t.text     "object_changes"
  end

  add_index "user_versions", ["item_type", "item_id"], name: "index_user_versions_on_item_type_and_item_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.date     "date_of_birth"
    t.string   "sex"
    t.integer  "height_inches"
    t.integer  "weight_ounces"
    t.text     "stripe_id"
    t.text     "family_note"
    t.string   "family_role"
    t.boolean  "early_access",           default: false
    t.boolean  "tara_referral",          default: false, null: false
    t.string   "zip_code"
    t.boolean  "qol_referral",           default: false, null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "due_date"
    t.integer  "registration_stage",     default: 0
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "time_zone"
    t.boolean  "physician_referral",     default: false
    t.boolean  "provider",               default: false
    t.text     "hospitals_or_practices"
    t.text     "academic_affiliations"
    t.string   "specialty"
    t.string   "subspecialty"
    t.string   "fax"
    t.boolean  "terms_accepted"
    t.integer  "monologue_user_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["date_of_birth"], name: "index_users_on_date_of_birth", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["monologue_user_id"], name: "index_users_on_monologue_user_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_user_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "user_role_id"
  end

  add_index "users_user_roles", ["user_id", "user_role_id"], name: "index_users_user_roles_on_user_id_and_user_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
