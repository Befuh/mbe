class Consultation < Sequel::Model
  many_to_one :patient

  def validate
    super
    validates_presence [:patient_id, :doctor_id, :health_facility_id, :timestamp]
  end
end
