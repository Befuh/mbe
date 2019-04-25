class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :house_number
      t.string :city
      t.string :zip_code
      t.string :state
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end

