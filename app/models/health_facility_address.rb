class HealthFacilityAddresss < ApplicationRecord
  belongs_to :health_facility
  belongs_to :address
end
