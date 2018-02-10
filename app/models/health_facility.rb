class HealthFacility < Sequel::Model
  many_to_many :doctors

  def validate
    super
    validates_presence [:name, :city, :country]
    validates_unique :name
  end
end
