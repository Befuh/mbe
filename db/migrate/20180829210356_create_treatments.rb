Sequel.migration do
  change do
    create_table :treatments do
      primary_key :id
      Integer :consultation_id
      String :type
      Text :description
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
