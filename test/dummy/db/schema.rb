# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_28_205512) do

  create_table "action_error_faults", force: :cascade do |t|
    t.integer "cause_id"
    t.text "backtrace"
    t.string "klass"
    t.text "message"
    t.string "controller"
    t.string "action"
    t.integer "instances_count"
    t.text "blamed_files"
    t.text "options"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cause_id"], name: "index_action_error_faults_on_cause_id"
    t.index ["klass", "backtrace", "message"], name: "index_action_error_faults_on_klass_and_backtrace_and_message"
  end

  create_table "action_error_instances", force: :cascade do |t|
    t.integer "fault_id"
    t.string "url"
    t.text "headers"
    t.text "parameters"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fault_id"], name: "index_action_error_instances_on_fault_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title"], name: "index_posts_on_title", unique: true
  end

end
