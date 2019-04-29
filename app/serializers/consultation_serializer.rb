class ConsultationSerializer
  attr_accessor :consultation

  def initialize(consultation)
    @consultation = consultation
  end

  def serialize
    {
      id: consultation.id,
      timestamp: consultation.timestamp.utc.iso8601,
      patient_id: consultation.patient_id,
      doctor_id: consultation.doctor_id,
      health_facility_id: consultation.health_facility_id,
      anamneses: { data: anamneses }
    }
  end

  private

  def anamneses
    consultation.anamneses.map do |an|
      {
        id: an.id,
        symptom_id: an.symptom_id,
        time_from: an.time_from.utc.iso8601,
        time_to: an.time_to ? an.time_to.utc.iso8601 : nil,
        additional_info: an.additional_info
      }
    end
  end
end
