Sequel.migration do
  change do
    create_table :clinical_observations do
      primary_key :id
      Integer :consultation_id
      String :exam
      String :result
      String :interpretation
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
