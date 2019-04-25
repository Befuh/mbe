class CreateConsultations < ActiveRecord::Migration[5.1]
  def change
    create_table :consultations do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :health_facility_id
      t.datetime :timestamp

      t.timestamps
    end
  end
end
