require 'rails_helper'

RSpec.describe 'Patients', type: :request do
  let!(:user) do
    FactoryBot.create(
      :user,
      first_name: 'John',
      gender: 'male',
      date_of_birth: Date.new(1986, 5, 5)
    )
  end

  before(:each) do
    FactoryBot.create(
      :patient,
      :with_address_and_pre_existing_conditions,
      user: user
    )
  end

  describe 'GET /patients' do
    it 'returns all patients' do
      get '/patients'

      expect(response).to be_success
      expect(json_response['data'].length).to eq 1

      result = json_response['data'][0]
      expect(result['id']).to_not be_nil
      expect(result['identifier']).to_not be_nil
      expect(result['address']['data']).to include({ 'city' => 'Buea', 'country' => 'CM' })
      expect(result['user']['data']).
        to include({ 'first_name' => 'John', 'gender' => 'male', 'date_of_birth' => '1986-05-05' })
      expect(result['pre_existing_conditions']['data'].length).to eq 1
      expect(result['pre_existing_conditions']['data'][0]).to include({ 'name' => 'diabetes' })
    end

    it 'returns empty array if no patients' do
      Address.destroy_all
      Patient.destroy_all

      get '/patients'

      expect(response).to be_success
      expect(json_response['data']).to be_empty
    end

    describe 'For search' do
      before do
        other_user = FactoryBot.create(:user, id: 1524, first_name: 'Foobar', auth_id: '343eg5')
        FactoryBot.create(:patient, user: other_user, id: 65433)
      end

      it 'returns only result for patient name' do
        get '/patients?first_name=Foobar'

        expect(response).to be_success
        expect(json_response['data'].length).to eq 1
        expect(json_response['data'][0]['id']).to eq 65433
      end

      it 'returns only result for patient name and gender' do
        get '/patients?first_name=Foobar&gender=male'

        expect(response).to be_success
        expect(json_response['data'].length).to eq 0
      end

      it 'returns only result for patient identifier' do
        patient = Patient.first
        get "/patients?identifier=#{patient.identifier}"

        expect(response).to be_success
        expect(json_response['data'].length).to eq 1
        expect(json_response['data'][0]['identifier']).to eq patient.identifier
      end
    end
  end

  describe 'GET /patients/:identifier' do
    it 'returns patient for given identifier' do
      patient = Patient.first

      get "/patients/#{patient.identifier}"

      expect(response).to be_success
      result = json_response['data']
      expect(result['id']).to eq patient.id
      expect(result['identifier']).to eq patient.identifier
      expect(result['address']['data']).to include({ 'city' => 'Buea', 'country' => 'CM' })
      expect(result['user']['data']).
        to include({ 'first_name' => 'John', 'gender' => 'male', 'date_of_birth' => '1986-05-05' })
      expect(result['pre_existing_conditions']['data'].length).to eq 1
      expect(result['pre_existing_conditions']['data'][0]).to include({ 'name' => 'diabetes' })
    end

    it 'returns 404 response status if patient does not exist' do
      identifier = Patient.first.identifier

      get "/patients/#{identifier}45"

      expect(response).to have_http_status(:missing)
    end
  end

  describe 'POST /patients' do
    let(:new_patient) do
      new_patient = {
        user: {
          first_name: 'Eposi', last_name: 'Buh',
          gender: 'female', date_of_birth: Date.new(1990, 1, 6)
        },
        address: { street: 'Malingo', city: 'Buea', country: 'CM' },
        pre_existing_conditions: [{ disease_id: Disease.first.id }]
      }
    end

    it 'creates new patient and returns created patient' do
      post '/patients', params: with_required_params(patient: new_patient)

      expect(response).to be_success
      result = json_response['data']
      expect(result['identifier']).to_not be_nil
      expect(result['address']['data']).
        to include({ 'street' => 'Malingo', 'city' => 'Buea', 'country' => 'CM' })
      expect(result['user']['data']).
        to include({
          'first_name' => 'Eposi', 'last_name' => 'Buh',
          'gender' => 'female', 'date_of_birth' => '1990-01-06'
        })
      expect(result['pre_existing_conditions']['data'].length).to eq 1
      expect(result['pre_existing_conditions']['data'][0]).to include({ 'name' => 'diabetes' })
    end

    it 'creates new patient when there is no address' do
      new_patient.delete(:address)

      post '/patients', params: with_required_params(patient: new_patient)

      expect(response).to be_success
      result = json_response['data']
      expect(result['address']['data']).to be_nil
      expect(result['user']['data']).to_not be_nil
      expect(result['pre_existing_conditions']['data'].length).to eq 1
    end

    it 'creates new patient when there are no pre_existing_conditions' do
      new_patient.delete(:pre_existing_conditions)

      post '/patients', params: with_required_params(patient: new_patient)

      expect(response).to be_success
      result = json_response['data']
      expect(result['address']['data']).to_not be_nil
      expect(result['user']['data']).to_not be_nil
      expect(result['pre_existing_conditions']['data'].length).to eq 0
    end

    it 'does not create patient if user data does not exists' do
      new_patient.delete(:user)

      expect do
        post '/patients', params: with_required_params(patient: new_patient)
      end.to_not change(Patient, :count)
    end

    it 'returns bad rquest response if user data does not exists' do
      new_patient.delete(:user)

      post '/patients', params: with_required_params(patient: new_patient)

      expect(response).to have_http_status(:bad_request)
    end
  end
end
