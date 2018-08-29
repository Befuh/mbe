Sequel.migration do
  change do
    create_table :patients_pre_existing_conditions do
      primary_key :id
      foreign_key :patient_id, :patients
      foreign_key :pre_existing_condition_id, :pre_existing_conditions
      Boolean :treated
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
