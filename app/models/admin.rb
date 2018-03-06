class Admin < Sequel::Model
  def validate
    super
    validates_presence [:user_id]
    validates_unique :user_id
  end
end
