Sequel.migration do
  change do
    create_table :pre_existing_conditions do
      primary_key :id
      String :name
    end
  end
end
