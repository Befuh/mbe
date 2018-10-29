Sequel.migration do
  change do
    create_table :consultations_symptoms do
      primary_key :id
      foreign_key :consultation_id, :consultations
      foreign_key :symptom_id, :symptoms
      Text :additional_info
      DateTime :time_from
      DateTime :time_to
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
