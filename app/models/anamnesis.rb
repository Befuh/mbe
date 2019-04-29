class Anamnesis < ApplicationRecord
  belongs_to :consultation
  belongs_to :symptom

  validates :time_from, presence: true
end
