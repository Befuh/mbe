class LabResult < ApplicationRecord
  belongs_to :consultation

  validates :consultation_id, :category, presence: true
end
