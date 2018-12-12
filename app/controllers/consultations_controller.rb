class ConsultationsController < ApplicationController
  before_action :set_patient

  def index
    consultations = Consultation.eager(
      :patient, :doctor, :health_facility).where(patient_id: @patient.id)

    render json: { data: consultations.map { |cons| ConsultationSerializer.new(cons).serialize }}
  end

  private

  def set_patient
    @patient = Patient[identifier: params[:patient_identifier]]

    render json: { error: 'Patient must exist.' }, status: :unprocessable_entity unless @patient
  end
end
