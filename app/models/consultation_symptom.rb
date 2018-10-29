class ConsultationSymptom < Sequel::Model(:consultations_symptoms)
  many_to_one :patient
  many_to_one :symptom
end
