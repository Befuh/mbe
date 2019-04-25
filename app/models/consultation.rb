class Consultation < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  belongs_to :health_facility
  has_many :anamneses
  has_many :symptoms, through: :anamneses
  has_and_belongs_to_many :diagnoses
  has_many :clinical_observations
  has_many :lab_results
  has_many :treatments

  validates :patient_id, :doctor_id, :health_facility_id, :timestamp, presence: true
end
