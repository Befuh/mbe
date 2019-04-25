class ConsultationsController < ApplicationController
  before_action :set_patient

  def index
    consultations = Consultation.includes(
      :patient, :doctor, :health_facility).where(patient_id: @patient.id)

    render json: { data: consultations.map { |cons| ConsultationIndexSerializer.new(cons).serialize }}
  end

  def show
    consultation = Consultation.find_by(patient_id: @patient.id, id: params[:id])
    render json: { data: ConsultationSerializer.new(consultation).serialize }
  end

  private

  def set_patient
    @patient = Patient.find_by(identifier: params[:patient_identifier])
  end
end
