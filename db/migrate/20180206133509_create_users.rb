class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :auth_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender
      t.date :date_of_birth

      t.timestamps
    end
  end
end
