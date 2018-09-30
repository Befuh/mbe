class PatientsController < ApplicationController
  def index
    patients = Patient.eager(:user, :address, :pre_existing_conditions).all
    render json: patients.map { |patient| PatientSerializer.new(patient).serialize }
  end
end
