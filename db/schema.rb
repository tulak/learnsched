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

ActiveRecord::Schema.define(version: 20161211170157) do

  create_table "goal_templates", force: :cascade do |t|
    t.string   "name"
    t.boolean  "public"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_goal_templates_on_owner_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "goal_template_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["goal_template_id"], name: "index_goals_on_goal_template_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "goal_template_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["goal_template_id"], name: "index_levels_on_goal_template_id"
  end

  create_table "task_schedules", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "goal_id"
    t.boolean  "completed"
    t.datetime "completed_at"
    t.datetime "scheduled_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["goal_id"], name: "index_task_schedules_on_goal_id"
    t.index ["task_id"], name: "index_task_schedules_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "level_id"
    t.string   "name"
    t.string   "description"
    t.string   "resources"
    t.integer  "estimated_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["level_id"], name: "index_tasks_on_level_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
