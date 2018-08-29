Sequel.migration do
  change do
    create_table :lab_results do
      primary_key :id
      Integer :consultation_id
      String :category
      String :value
      String :unit
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
