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

ActiveRecord::Schema.define(version: 20141001002437) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characterizations", force: true do |t|
    t.integer  "project_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characterizations", ["category_id"], name: "index_characterizations_on_category_id"
  add_index "characterizations", ["project_id"], name: "index_characterizations_on_project_id"

  create_table "passions", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passions", ["project_id"], name: "index_passions_on_project_id"
  add_index "passions", ["user_id"], name: "index_passions_on_user_id"

  create_table "pledges", force: true do |t|
    t.text     "comment"
    t.integer  "amount"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "pledges", ["project_id"], name: "index_pledges_on_project_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "target_pledge_amount"
    t.date     "pledging_ends_on"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "team_members"
    t.string   "image_file_name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

end
