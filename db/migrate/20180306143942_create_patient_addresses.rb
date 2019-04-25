class CreatePatientAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_addresses do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :address, index: true

      t.timestamps
    end
  end
end
