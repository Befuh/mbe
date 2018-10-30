Sequel.migration do
  change do
    create_table :consultations_diagnoses do
      primary_key :id
      foreign_key :consultation_id, :consultations
      foreign_key :diagnosis_id, :diagnoses
    end
  end
end
