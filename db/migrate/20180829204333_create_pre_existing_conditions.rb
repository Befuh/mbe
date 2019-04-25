class CreatePreExistingConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :pre_existing_conditions do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :disease, index: true
      t.boolean :treated

      t.timestamps
    end
  end
end
