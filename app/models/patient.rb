class Patient < Sequel::Model
  one_through_one :address
  def validate
    super
    validates_presence [:identifer, :user_id]
    validates_unique :identifer
    validates_unique :user_id
  end
end
