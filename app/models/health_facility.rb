class HealthFacility < Sequel::Model
  many_to_many :doctors
  many_to_many :addresses

  def validate
    super
    validates_presence [:name]
    validates_unique :name
  end
end
