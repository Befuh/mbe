class LabResult < Sequel::Model
  many_to_one :consultation

  def validate
    super
    validates_presence [:consultation_id, :category]
  end
end
