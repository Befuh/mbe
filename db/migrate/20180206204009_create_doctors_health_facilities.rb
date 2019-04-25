class CreateDoctorsHealthFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors_health_facilities, id: false do |t|
      t.belongs_to :doctor, index: true
      t.belongs_to :health_facility, index: true
    end
  end
end
