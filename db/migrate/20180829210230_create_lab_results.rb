class CreateLabResults < ActiveRecord::Migration[5.1]
  def change
    create_table :lab_results do |t|
      t.integer :consultation_id
      t.string :category
      t.string :value
      t.string :unit

      t.timestamps
    end
  end
end
