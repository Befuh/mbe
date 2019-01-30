class PatientsController < ApplicationController
  before_action :set_patient, only: [:show]

  def index
    patients = query_patients.all
    render json: { data: patients.map { |patient| PatientSerializer.new(patient).serialize }}
  end

  def show
    render json: { data: PatientSerializer.new(@patient).serialize }
  end

  def create
    user = create_user

    render json: { error: 'User must be provided' }, status: :bad_request and return unless user

    patient = Patient.create(user_id: user.id)
    patient.address = create_address

    if create_patient_params[:pre_existing_conditions].present?
      create_patient_params[:pre_existing_conditions].map do |pre_existing_condition_id|
        pre_existing_condition = PreExistingCondition[id: pre_existing_condition_id.to_i]
        patient.add_pre_existing_condition(pre_existing_condition) if pre_existing_condition
      end
    end

    patient.save

    render json: { data: PatientSerializer.new(patient).serialize }
  end

  private

  def set_patient
    @patient = Patient[identifier: params[:identifier]]

    render json: { error: 'Patient not found' }, status: :not_found unless @patient
  end

  def create_patient_params
    params.require(:patient).permit(
      user: [:first_name, :last_name, :sex, :date_of_birth],
      address: [:street, :house_number, :city, :zip_code, :state, :country, :phone],
      pre_existing_conditions: []
    )
  end

  def create_user
    user_params = create_patient_params[:user]

    return unless user_params

    User.create(user_params.merge(auth_id: SecureRandom.hex(6)))
  end

  def create_address
    return unless create_patient_params[:address]

    Address.create(create_patient_params[:address])
  end

  def query_patients
    query = Patient.eager_graph(:user, :address, :pre_existing_conditions)

    query = sequel_ilike(query, :first_name) if params[:first_name].present?

    query = sequel_ilike(query, :last_name) if params[:last_name].present?

    query = query.where(sex: params[:sex]) if params[:sex].present?

    query
  end

  def sequel_ilike(query, field)
    value = "%#{params[field]}%"
    query.where { Sequel.ilike(:first_name, value) }
  end
end
