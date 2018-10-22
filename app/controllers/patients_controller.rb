class PatientsController < ApplicationController
  before_action :set_patient, except: [:create, :index]

  def index
    patients = Patient.eager(:user, :address, :pre_existing_conditions).all
    render json: { data: patients.map { |patient| PatientSerializer.new(patient).serialize }}
  end

  def show
    render json: { data: PatientSerializer.new(@patient).serialize }
  end

  private

  def set_patient
    @patient = Patient[identifier: params[:identifier]]

    render json: { error: 'Patient not found' }, status: 404 unless @patient
  end
end
