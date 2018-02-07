class Patient < Sequel::Model
  def validate
    super
    validates_presence [:patient_id, :user_id]
    validates_unique :patient_id
    validates_unique :user_id
  end
end
