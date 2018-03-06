Sequel.migration do
  change do
    create_table :doctors do
      primary_key :id
      Integer :user_id, null: false, unique: true
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
