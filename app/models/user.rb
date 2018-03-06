class User < Sequel::Model
  def validate
    super
    validates_presence [:auth_id, :first_name, :last_name]
    validates_unique :auth_id
    validates_includes ['male', 'female'], :sex
  end
end
