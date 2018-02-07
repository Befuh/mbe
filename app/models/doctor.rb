class Doctor < Sequel::Model
  many_to_many :health_facilities

  def validate
    super
    validates_presence [:doctor_id, :user_id]
    validates_unique :doctor_id
    validates_unique :user_id
  end
end
