class Consultation < Sequel::Model
  many_to_one :patient
  many_to_one :doctor
  many_to_one :health_facility
  many_to_many :symptoms
  many_to_many :diagnoses
  one_to_many :clinical_observations
  one_to_many :lab_results
  one_to_many :treatments

  def validate
    super
    validates_presence [:patient_id, :doctor_id, :health_facility_id, :timestamp]
  end
end
