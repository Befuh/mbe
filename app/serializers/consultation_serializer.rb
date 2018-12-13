class ConsultationSerializer
  attr_accessor :consultation

  def initialize(consultation)
    @consultation = consultation
  end

  def serialize
    {
      id: consultation.id,
      timestamp: consultation.timestamp.utc.iso8601
    }
  end
end
