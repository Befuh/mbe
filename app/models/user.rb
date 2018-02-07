class User < Sequel::Model
  def validate
    super
    validates_presence [:user_id, :first_name, :last_name]
    validates_unique :user_id
  end
end
