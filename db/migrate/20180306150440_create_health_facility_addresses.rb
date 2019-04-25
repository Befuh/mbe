class CreateHealthFacilityAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :health_facility_addresses do |t|
      t.belongs_to :health_facility, index: true
      t.belongs_to :address, index: true

      t.timestamps
    end
  end
end
