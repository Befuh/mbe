class Address < ApplicationRecord
  has_many :patient_addresses
  has_many :patients, through: :patient_addresses
  has_many :health_facility_addresses
  has_many :health_facilities, through: :health_facility_addresses

  validates :city, :country, presence: true
end
