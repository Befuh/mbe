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

ActiveRecord::Schema.define(version: 20181030205849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "house_number"
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.string "country"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anamneses", force: :cascade do |t|
    t.bigint "consultation_id"
    t.bigint "symptom_id"
    t.text "additional_info"
    t.datetime "time_from"
    t.datetime "time_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_id"], name: "index_anamneses_on_consultation_id"
    t.index ["symptom_id"], name: "index_anamneses_on_symptom_id"
  end

  create_table "clinical_observations", force: :cascade do |t|
    t.integer "consultation_id"
    t.string "exam"
    t.string "result"
    t.string "interpretation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultations", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "doctor_id"
    t.integer "health_facility_id"
    t.datetime "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultations_diagnoses", id: false, force: :cascade do |t|
    t.bigint "consultation_id"
    t.bigint "diagnosis_id"
    t.index ["consultation_id"], name: "index_consultations_diagnoses_on_consultation_id"
    t.index ["diagnosis_id"], name: "index_consultations_diagnoses_on_diagnosis_id"
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors_health_facilities", id: false, force: :cascade do |t|
    t.bigint "doctor_id"
    t.bigint "health_facility_id"
    t.index ["doctor_id"], name: "index_doctors_health_facilities_on_doctor_id"
    t.index ["health_facility_id"], name: "index_doctors_health_facilities_on_health_facility_id"
  end

  create_table "health_facilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_facility_addresses", force: :cascade do |t|
    t.bigint "health_facility_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_health_facility_addresses_on_address_id"
    t.index ["health_facility_id"], name: "index_health_facility_addresses_on_health_facility_id"
  end

  create_table "lab_results", force: :cascade do |t|
    t.integer "consultation_id"
    t.string "category"
    t.string "value"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_addresses", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_patient_addresses_on_address_id"
    t.index ["patient_id"], name: "index_patient_addresses_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "identifier", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pre_existing_conditions", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "disease_id"
    t.boolean "treated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disease_id"], name: "index_pre_existing_conditions_on_disease_id"
    t.index ["patient_id"], name: "index_pre_existing_conditions_on_patient_id"
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatments", force: :cascade do |t|
    t.integer "consultation_id"
    t.string "type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "auth_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "gender"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
