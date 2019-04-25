class CreateTreatments < ActiveRecord::Migration[5.1]
  def change
    create_table :treatments do |t|
      t.integer :consultation_id
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
