class Address < Sequel::Model
  many_to_many :patients
  many_to_many :health_facilities
  def validate
    super
    validates_presence [:city, :country]
  end
end
