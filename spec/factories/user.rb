FactoryBot.define do
  factory :user do
    auth_id { '345dssf4' }
    first_name { 'June' }
    last_name { 'Doe' }
    gender { 'female' }
    date_of_birth { Date.new(1999, 1, 1) }
  end
end
