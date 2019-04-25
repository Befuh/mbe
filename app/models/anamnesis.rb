class Anamnesis < ApplicationRecord
  belongs_to :consultation
  belongs_to :symptom
end
