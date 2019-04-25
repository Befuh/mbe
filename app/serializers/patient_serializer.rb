class PatientSerializer
  attr_accessor :patient

  def initialize(patient)
    @patient = patient
  end

  def serialize
    {
      id: patient.id,
      identifier: patient.identifier,
      user: { data: user },
      address: { data: address },
      pre_existing_conditions: { data: pre_existing_conditions }
    }
  end

  private

  def user
    return unless patient.user

    user = patient.user

    {
      id: user.id,
      auth_id: user.auth_id,
      first_name: user.first_name,
      last_name: user.last_name,
      date_of_birth: user.date_of_birth ? user.date_of_birth.strftime('%Y-%m-%d') : nil,
      gender: user.gender
    }
  end

  def address
    return unless patient.address

    address = patient.address

    {
      street: address.street,
      house_number: address.house_number,
      zipcode: address.zip_code,
      city: address.city,
      country: address.country
    }
  end

  def pre_existing_conditions
    patient.pre_existing_conditions.map do |pec|
      { id: pec.id, name: pec.disease.name }
    end
  end
end
