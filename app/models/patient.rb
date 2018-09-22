class Patient < Sequel::Model
  one_through_one :address
  def validate
    super
    validates_presence [:identifier, :user_id]
    validates_unique :identifier
    validates_unique :user_id
  end
end
