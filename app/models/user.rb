class User < ApplicationRecord
  GENDERS = %w(male female)

  has_one :patient
  has_one :doctor

  validates :auth_id, :first_name, :last_name, presence: true
  validates :auth_id, uniqueness: true
  validates :gender, inclusion: { in: GENDERS, message: '%{value} is not a valid gender' }
end
