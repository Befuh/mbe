Sequel.migration do
  change do

    create_table :users do
      primary_key :id
      String :auth_id, null: false, unique: true
      String :first_name, null: false
      String :last_name, null: false
      String :sex
      Date :date_of_birth
      DateTime :created_at
      DateTime :updated_at
    end

  end
end
