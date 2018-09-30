require 'rails_helper'

RSpec.describe 'Patients', type: :request do
  let!(:user) {
    FactoryBot.create(
      :user,
      id: 1,
      first_name: 'John',
      sex: 'male',
      date_of_birth: Date.new(1986, 5, 5)
    )
  }

  let!(:patient) {
    FactoryBot.create(
      :patient,
      :with_address_and_pre_existing_conditions,
      user: user,
      id: 42,
      identifier: 'foobar'
    )
  }

  describe "GET /patients" do
    it 'returns all patients' do
      get '/patients'

      expect(response).to be_success
      expect(json_response.length).to eq 1

      result = json_response[0]
      expect(result['id']).to eq 42
      expect(result['identifier']).to eq 'foobar'
      expect(result['address']['data']).to include({ 'city' => 'Buea', 'country' => 'CM' })
      expect(result['user']['data']).
        to include({ 'first_name' => 'John', 'sex' => 'male', 'date_of_birth' => '1986-05-05' })
      expect(result['pre_existing_conditions']['data'].length).to eq 1
      expect(result['pre_existing_conditions']['data'][0]).to include({ 'name' => 'diabetes' })
    end
  end
end
