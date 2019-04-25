class PatientAddress < ApplicationRecord
  belongs_to :patient
  belongs_to :address
end
