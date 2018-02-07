Sequel.migration do
  change do
    create_table :patients do
      primary_key :id
      String :patient_id, null: false, unique: true
      String :user_id, null: false, unique: true
      String :city
      String :state
      String :country_id
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
