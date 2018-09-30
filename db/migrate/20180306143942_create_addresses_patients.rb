Sequel.migration do
  change do
    create_table :addresses_patients do
      primary_key :id
      foreign_key :patient_id, :patients
      foreign_key :address_id, :addresses
    end
  end
end
