require 'rails_helper'

RSpec.describe 'Consultations', type: :request do
  let(:timestamp) { DateTime.new(2018, 12, 5).utc }
  let!(:user) { FactoryBot.create(:user, id: 1001, first_name: 'Foo', last_name: 'Bar') }
  let!(:patient) { FactoryBot.create(:patient, id: 4001, user: user) }
  let!(:doctor) { FactoryBot.create(:doctor, id: 4002, user: user) }
  let!(:health_facility) { FactoryBot.create(:health_facility, name: 'Biaka') }

  describe 'GET /consultations' do
    before do
      FactoryBot.create(
        :consultation,
        patient: patient,
        doctor: doctor,
        health_facility: health_facility,
        timestamp: timestamp)
    end

    it 'returns all consultations' do
      get "/patients/#{patient.identifier}/consultations"

      expect(response).to be_success
      expect(json_response['data'].length).to eq 1

      result = json_response['data'][0]
      expect(result['timestamp']).to eq timestamp.iso8601
      expect(result['patient']['data']['identifier']).to_not be_nil
      expect(result['doctor']['data']).
        to include({ 'first_name' => 'Foo', 'last_name' => 'Bar' })
      expect(result['health_facility']['data']).to include({ 'name' => 'Biaka'})
    end
  end
end
