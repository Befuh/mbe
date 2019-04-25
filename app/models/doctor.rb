class Doctor < ApplicationRecord
  belongs_to :user
  has_many :consultations
  has_and_belongs_to_many :health_facilities

  validates :user_id, presence: true
  validates :user_id, uniqueness: true
end
