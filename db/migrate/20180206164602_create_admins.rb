Sequel.migration do
  change do
    create_table :admins do
      primary_key :id
      String :admin_id, null: false, unique: true
      String :user_id, null: false, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
