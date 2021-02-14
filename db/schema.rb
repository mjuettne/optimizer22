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

ActiveRecord::Schema.define(version: 2021_02_12_204132) do

  create_table "asset_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "broad_type"
    t.string "subtype"
    t.string "goal"
  end

  create_table "cma_inputs", force: :cascade do |t|
    t.integer "cma_id"
    t.float "exp_ret"
    t.float "std_dev"
    t.float "skew"
    t.float "kurt"
    t.float "yield"
    t.integer "asset_class_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cmas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "correlation_inputs", force: :cascade do |t|
    t.integer "correlation_id"
    t.integer "asset_class1_id"
    t.integer "asset_class2_id"
    t.float "correl"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "correlations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "forecast_inputs", force: :cascade do |t|
    t.integer "forecast_id"
    t.float "inflation"
    t.float "starting_value"
    t.float "income"
    t.float "spend_value"
    t.integer "years_income"
    t.integer "years_forecast"
    t.integer "portfolio1_id"
    t.integer "portfolio2_id"
    t.float "weight_port1"
    t.float "weight_port2"
    t.integer "cma_id"
    t.integer "correlation_id"
    t.float "year1_cf"
    t.float "year2_cf"
    t.float "year3_cf"
    t.float "year4_cf"
    t.float "year5_cf"
    t.float "year6_cf"
    t.float "year7_cf"
    t.float "year8_cf"
    t.float "year9_cf"
    t.float "year10_cf"
    t.float "year11_cf"
    t.float "year12_cf"
    t.float "year13_cf"
    t.float "year14_cf"
    t.float "year15_cf"
    t.float "year16_cf"
    t.float "year17_cf"
    t.float "year18_cf"
    t.float "year19_cf"
    t.float "year20_cf"
    t.float "year21_cf"
    t.float "year22_cf"
    t.float "year23_cf"
    t.float "year24_cf"
    t.float "year25_cf"
    t.float "year26_cf"
    t.float "year27_cf"
    t.float "year28_cf"
    t.float "year29_cf"
    t.float "year30_cf"
    t.integer "year1_cma_id"
    t.integer "year2_cma_id"
    t.integer "year3_cma_id"
    t.integer "year4_cma_id"
    t.integer "year5_cma_id"
    t.integer "year6_cma_id"
    t.integer "year7_cma_id"
    t.integer "year8_cma_id"
    t.integer "year9_cma_id"
    t.integer "year10_cma_id"
    t.integer "year11_cma_id"
    t.integer "year12_cma_id"
    t.integer "year13_cma_id"
    t.integer "year14_cma_id"
    t.integer "year15_cma_id"
    t.integer "year16_cma_id"
    t.integer "year17_cma_id"
    t.integer "year18_cma_id"
    t.integer "year19_cma_id"
    t.integer "year20_cma_id"
    t.integer "year21_cma_id"
    t.integer "year22_cma_id"
    t.integer "year23_cma_id"
    t.integer "year24_cma_id"
    t.integer "year25_cma_id"
    t.integer "year26_cma_id"
    t.integer "year27_cma_id"
    t.integer "year28_cma_id"
    t.integer "year29_cma_id"
    t.integer "year30_cma_id"
    t.integer "year1_correl_id"
    t.integer "year2_correl_id"
    t.integer "year3_correl_id"
    t.integer "year4_correl_id"
    t.integer "year5_correl_id"
    t.integer "year6_correl_id"
    t.integer "year7_correl_id"
    t.integer "year8_correl_id"
    t.integer "year9_correl_id"
    t.integer "year10_correl_id"
    t.integer "year11_correl_id"
    t.integer "year12_correl_id"
    t.integer "year13_correl_id"
    t.integer "year14_correl_id"
    t.integer "year15_correl_id"
    t.integer "year16_correl_id"
    t.integer "year17_correl_id"
    t.integer "year18_correl_id"
    t.integer "year19_correl_id"
    t.integer "year20_correl_id"
    t.integer "year21_correl_id"
    t.integer "year22_correl_id"
    t.integer "year23_correl_id"
    t.integer "year24_correl_id"
    t.integer "year25_correl_id"
    t.integer "year26_correl_id"
    t.integer "year27_correl_id"
    t.integer "year28_correl_id"
    t.integer "year29_correl_id"
    t.integer "year30_correl_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "user_id"
    t.float "year1_exp"
    t.float "year2_exp"
    t.float "year3_exp"
    t.float "year4_exp"
    t.float "year5_exp"
    t.float "year6_exp"
    t.float "year7_exp"
    t.float "year8_exp"
    t.float "year9_exp"
    t.float "year10_exp"
    t.float "year11_exp"
    t.float "year12_exp"
    t.float "year13_exp"
    t.float "year14_exp"
    t.float "year15_exp"
    t.float "year16_exp"
    t.float "year17_exp"
    t.float "year18_exp"
    t.float "year19_exp"
    t.float "year20_exp"
    t.float "year21_exp"
    t.float "year22_exp"
    t.float "year23_exp"
    t.float "year24_exp"
    t.float "year25_exp"
    t.float "year26_exp"
    t.float "year27_exp"
    t.float "year28_exp"
    t.float "year29_exp"
    t.float "year30_exp"
  end

  create_table "forecasts", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "frontier_inputs", force: :cascade do |t|
    t.integer "asset_class_id"
    t.integer "frontier_id"
    t.integer "cma_id"
    t.integer "correlation_id"
    t.integer "min"
    t.integer "max"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "inclusion"
  end

  create_table "frontiers", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cma_id"
    t.integer "correlation_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cma_id"
    t.integer "correlation_id"
    t.integer "benchmark"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weights", force: :cascade do |t|
    t.integer "portfolio_id"
    t.float "weight"
    t.integer "asset_class_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "inclusion"
  end

end
