# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_04_022155) do
  create_table "active_error_faults", force: :cascade do |t|
    t.integer "cause_id"
    t.text "backtrace"
    t.string "klass"
    t.text "message"
    t.string "controller"
    t.string "action"
    t.integer "instances_count"
    t.text "blamed_files"
    t.text "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cause_id"], name: "index_active_error_faults_on_cause_id"
    t.index ["klass", "backtrace", "message"], name: "index_active_error_faults_on_klass_and_backtrace_and_message"
  end

  create_table "active_error_instances", force: :cascade do |t|
    t.integer "fault_id"
    t.string "url"
    t.text "headers"
    t.text "parameters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fault_id"], name: "index_active_error_instances_on_fault_id"
  end

end
