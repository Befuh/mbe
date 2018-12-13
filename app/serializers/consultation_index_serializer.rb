class ConsultationIndexSerializer
  attr_accessor :consultation

  def initialize(consultation)
    @consultation = consultation
  end

  def serialize
    {
      id: consultation.id,
      timestamp: consultation.timestamp.utc.iso8601,
      patient: { data: patient },
      doctor: { data: doctor },
      health_facility: { data: health_facility }
    }
  end

  private

  def patient
    { identifier: consultation.patient.identifier }
  end

  def doctor
    doctor_user = consultation.doctor.user
    {
      id: doctor_user.id,
      first_name: doctor_user.first_name,
      last_name: doctor_user.last_name
    }
  end

  def health_facility
    {
      name: consultation.health_facility.name
    }
  end
end
