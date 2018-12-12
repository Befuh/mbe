class Doctor < Sequel::Model
  many_to_one :user
  many_to_many :health_facilities

  def validate
    super
    validates_presence [:user_id]
    validates_unique :user_id
  end
end
