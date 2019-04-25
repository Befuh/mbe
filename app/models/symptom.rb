class Symptom < ApplicationRecord
  has_many :anamneses
  has_many :consultations, through: :anamneses
end
