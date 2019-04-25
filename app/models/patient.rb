class Patient < ApplicationRecord
  belongs_to :user
  has_one :patient_address
  has_one :address, through: :patient_address
  has_many :pre_existing_conditions
  accepts_nested_attributes_for :pre_existing_conditions, allow_destroy: true

  validates :identifier, :user_id, presence: true
  validates :identifier, :user_id, uniqueness: true

  before_validation :generate_identifier, on: :create

  private

  def generate_identifier
    loop do
      self.identifier = SecureRandom.hex(3).upcase
      break if self.class.find_by(identifier: identifier).blank?
    end
  end
end
