class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :identifier, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
