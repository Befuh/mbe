class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.string :user_id, null: false

      t.timestamps
    end
  end
end
