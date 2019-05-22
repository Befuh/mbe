class PatientsController < ApplicationController
  before_action :set_patient, only: [:show]

  def index
    patients = query_patients
    render json: { data: patients.map { |pat| PatientSerializer.new(pat).serialize }}
  end

  def show
    render json: { data: PatientSerializer.new(@patient).serialize }
  end

  def create
    user = create_user

    unless user
      render_bad_request(OpenStruct.new(message: 'User must be provided')) and return
    end

    attributes = { user_id: user.id }

    if patient_params[:pre_existing_conditions].present?
      attributes.merge!(
        pre_existing_conditions_attributes: patient_params[:pre_existing_conditions])
    end

    patient = Patient.create!(attributes)

    if patient_params[:address].present?
      address = Address.create!(patient_params[:address])
      patient.create_patient_address!(address_id: address.id)
    end

    render json: { data: PatientSerializer.new(patient).serialize }
  end

  private

  def set_patient
    @patient = Patient.find_by!(identifier: params[:identifier])
  end

  def patient_params
    params.require(:patient).permit(
      user: [:first_name, :last_name, :gender, :date_of_birth],
      address: [:street, :house_number, :city, :zip_code, :state, :country, :phone],
      pre_existing_conditions: [:disease_id]
    )
  end

  def create_user
    user_params = patient_params[:user]

    return unless user_params

    User.create!(user_params.merge(auth_id: SecureRandom.hex(6)))
  end

  def query_patients
    query = Patient.left_outer_joins(:user, :address, :pre_existing_conditions)

    query = sequel_ilike(query, :first_name) if params[:first_name].present?

    query = sequel_ilike(query, :last_name) if params[:last_name].present?

    query = query.where(identifier: params[:identifier]) if params[:identifier].present?

    query = query.where('users.gender = ?', params[:gender]) if params[:gender].present?

    query
  end

  def sequel_ilike(query, field)
    query.where("users.#{field} ILIKE ?", "%#{params[field]}%")
  end
end
