Sequel.migration do
  change do
    create_table :patients do
      primary_key :id
      String :identifier, null: false, unique: true
      Integer :user_id, null: false, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
