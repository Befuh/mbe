class HealthFacility < ApplicationRecord
  has_many :consultations
  has_and_belongs_to_many :doctors
  has_and_belongs_to_many :addresses

  validates :name, presence: true
  validates :name, uniqueness: true
end
