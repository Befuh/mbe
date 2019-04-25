class CreateAnamneses < ActiveRecord::Migration[5.1]
  def change
    create_table :anamneses do |t|
      t.belongs_to :consultation, index: true
      t.belongs_to :symptom, index: true
      t.text :additional_info
      t.datetime :time_from
      t.datetime :time_to

      t.timestamps
    end
  end
end
