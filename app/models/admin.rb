class Admin < Sequel::Model
  def validate
    super
    validates_presence [:admin_id, :user_id]
    validates_unique :admin_id
    validates_unique :user_id
  end
end
