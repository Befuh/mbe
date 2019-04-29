require 'rails_helper'

RSpec.describe 'Consultations', type: :request do
  let(:timestamp) { DateTime.new(2018, 12, 5).utc }
  let!(:user) { FactoryBot.create(:user, first_name: 'Foo', last_name: 'Bar') }
  let!(:patient) { FactoryBot.create(:patient, user: user) }
  let!(:doctor) { FactoryBot.create(:doctor, user: user) }
  let!(:health_facility) { FactoryBot.create(:health_facility, name: 'Biaka') }
  let!(:symptom) { FactoryBot.create(:symptom, name: 'back ache') }

  describe 'GET /patients/:patient_identifer/consultations' do
    before do
      FactoryBot.create(
        :consultation,
        patient: patient,
        doctor: doctor,
        health_facility: health_facility,
        timestamp: timestamp)
    end

    it 'returns all consultations for given patient' do
      get "/patients/#{patient.identifier}/consultations"

      expect(response).to be_success
      expect(json_response['data'].length).to eq 1

      result = json_response['data'][0]
      expect(result['timestamp']).to eq timestamp.iso8601
      expect(result['patient']['data']['identifier']).to_not be_nil
      expect(result['doctor']['data']).
        to include({ 'first_name' => 'Foo', 'last_name' => 'Bar' })
      expect(result['health_facility']['data']).to include({ 'name' => 'Biaka' })
    end

    it 'returns empty array if no consultations for given patient' do
      Consultation.where(patient_id: patient.id).destroy_all

      get "/patients/#{patient.identifier}/consultations"

      expect(response).to be_success
      expect(json_response['data']).to be_empty
    end
  end

  describe 'GET /patients/:patient_identifer/consultations/:id' do
    let(:consultation) do
      FactoryBot.create(
        :consultation,
        patient: patient,
        doctor: doctor,
        health_facility: health_facility,
        timestamp: timestamp)
    end

    it 'returns consultation for given patient and id' do
      get "/patients/#{patient.identifier}/consultations/#{consultation.id}"

      expect(response).to be_success
      result = json_response['data']
      expect(result['timestamp']).to eq timestamp.iso8601
    end
  end

  describe 'POST /patients/:patient_identifer/consultations' do
    let(:time_from) { DateTime.new(2018, 12, 5, 12, 0, 0).utc }
    let(:new_consultation) do
      {
        patient_id: patient.id,
        doctor_id: doctor.id,
        health_facility_id: health_facility.id,
        timestamp: timestamp,
        anamneses: [{ symptom_id: symptom.id, time_from: time_from }]
      }
    end

    it 'create new consultation and returns created consultation' do
      post(
        "/patients/#{patient.identifier}/consultations",
        params: with_required_params(consultation: new_consultation))

      expect(response).to be_success
      result = json_response['data']
      expect(result['timestamp']).to eq timestamp.iso8601
      expect(result['patient_id']).to eq patient.id
      expect(result['doctor_id']).to eq doctor.id
      expect(result['health_facility_id']).to eq health_facility.id
      expect(result['anamneses']['data'].length).to eq 1
      expect(result['anamneses']['data'][0]).
        to include({ 'time_from' => time_from.iso8601 })
    end

    it 'returns bad request response if patient does not exists' do
      post(
        "/patients/#{patient.identifier}345/consultations",
        params: with_required_params(consultation: new_consultation))

      expect(response).to have_http_status(:not_found)
    end
  end
end
