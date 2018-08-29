Sequel.migration do
  change do
    create_table :consultations do
      primary_key :id
      DateTime :timestamp
      Integer :patient_id
      Integer :doctor_id
      Integer :health_facility_id
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
