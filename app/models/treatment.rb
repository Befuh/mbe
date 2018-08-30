class Treatment < Sequel::Model
  many_to_one :consultation

  def validate
    super
    validates_presence [:consultation_id, :type, :description]
  end
end
