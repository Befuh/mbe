class CreateConsultationsDiagnoses < ActiveRecord::Migration[5.1]
  def change
    create_table :consultations_diagnoses, id: false do |t|
      t.belongs_to :consultation, index: true
      t.belongs_to :diagnosis, index: true
    end
  end
end

