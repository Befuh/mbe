class User < Sequel::Model
  one_to_one :patient

  def validate
    super
    validates_presence [:auth_id, :first_name, :last_name]
    validates_unique :auth_id
    validates_includes ['male', 'female'], :sex
  end
end
