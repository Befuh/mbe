class ConsultationsController < ApplicationController
  before_action :set_patient
  before_action :set_consultation, only: [:show, :update]

  def index
    consultations = Consultation.includes(
      :patient, :doctor, :health_facility).where(patient_id: @patient.id)
    data = consultations.map { |cons| ConsultationIndexSerializer.new(cons).serialize }

    render json: { data: data }
  end

  def show
    render json: { data: ConsultationSerializer.new(@consultation).serialize }
  end

  def create
    render_bad_request(
      OpenStruct.new(message: 'Mismatch id')) and return if patient_id_mismatch?

    attributes = consultation_params.slice(
      :timestamp, :patient_id, :doctor_id, :health_facility_id)

    if consultation_params[:anamneses].present?
      attributes[:anamneses_attributes] = consultation_params[:anamneses]
    end

    consultation = Consultation.create!(attributes)

    render json: { data: ConsultationSerializer.new(consultation).serialize }
  end

  def update
    render_bad_request(
      OpenStruct.new(message: 'Mismatch id')) and return if patient_id_mismatch?

    attributes = consultation_params.slice(:timestamp, :health_facility_id)

    if consultation_params[:anamneses].present?
      attributes[:anamneses_attributes] = consultation_params[:anamneses]
    end

    @consultation.update!(attributes)

    render json: { data: ConsultationSerializer.new(@consultation).serialize }
  end

  private

  def set_patient
    @patient = Patient.find_by!(identifier: params[:patient_identifier])
  end

  def set_consultation
    @consultation = Consultation.find_by!(patient_id: @patient.id, id: params[:id])
  end

  def consultation_params
    params.require(:consultation).permit(
      :timestamp,
      :patient_id,
      :doctor_id,
      :health_facility_id,
      anamneses: [:id, :symptom_id, :time_from, :time_to, :additional_info, :_destroy]
    )
  end

  def patient_id_mismatch?
    @patient.id != consultation_params[:patient_id].to_i
  end
end
