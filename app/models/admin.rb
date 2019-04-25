class Admin < ApplicationRecord
  validates :user_id, presence: true
  validates :user_id, uniqueness: true
end
