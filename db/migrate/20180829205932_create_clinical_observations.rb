class CreateClinicalObservations < ActiveRecord::Migration[5.1]
  def change
    create_table :clinical_observations do |t|
      t.integer :consultation_id
      t.string :exam
      t.string :result
      t.string :interpretation

      t.timestamps
    end
  end
end
