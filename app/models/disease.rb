class Disease < ApplicationRecord
  has_many :pre_existing_conditions
  has_many :patients, through: :pre_existing_conditions

  validates :name, presence: true
end
