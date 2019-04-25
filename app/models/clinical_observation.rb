class ClinicalObservation < ApplicationRecord
  belongs_to :consultation

  validates :consultation_id, :exam, presence: true
end
