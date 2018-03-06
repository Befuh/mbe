Sequel.migration do
  change do
    create_table :health_facilities_addresses do
      primary_key :id
      foreign_key :health_facility_id, :health_facilities
      foreign_key :address_id, :addresses
    end
  end
end
