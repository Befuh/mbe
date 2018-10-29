class Symptom < Sequel::Model
  many_to_many :consultations
end
