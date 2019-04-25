class Treatment < ApplicationRecord
  belongs_to :consultation

  validates :consultation_id, :type, :description, presence: true
end
