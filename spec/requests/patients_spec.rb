require 'rails_helper'

RSpec.describe 'Patients', type: :request do
  let!(:user) {
    FactoryBot.create(
      :user,
      first_name: 'John',
      last_name: 'Doe',
      sex: 'Male',
      date_of_birth: Date.new(1986, 5, 5)
    )
  }
  let!(:address) { FactoryBot.create(:address, ) }
  let!(:patient) { FactoryBot.create(:patient, identifier: 'foobar', user_id: user.id) }

  describe "GET /patients" do
    it 'returns all patients' do
      get '/patients'

      expect(response).to be_success
      expect(json_response.length).to eq 1
    end
  end
end
