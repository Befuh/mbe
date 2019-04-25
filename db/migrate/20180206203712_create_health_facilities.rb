class CreateHealthFacilities < ActiveRecord::Migration[5.1]
  def change
    create_table :health_facilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
