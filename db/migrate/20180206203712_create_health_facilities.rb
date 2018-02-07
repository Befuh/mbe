Sequel.migration do
  change do
    create_table :health_facilities do
      primary_key :id
      String :name
      String :street
      String :city
      String :state
      String :country_id
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
