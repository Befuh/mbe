Sequel.migration do
  change do
    create_table :addresses do
      primary_key :id
      String :street
      String :house_number
      String :city
      String :zip_code
      String :state
      String :country
      String :phone
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
