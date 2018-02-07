Sequel.migration do
  change do
    create_table :doctors_health_facilities do
      primary_key :id
      foreign_key :doctor_id, :doctors
      foreign_key :health_facility_id, :health_facilities
    end
  end
end
