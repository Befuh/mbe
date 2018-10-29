FactoryBot.define do
  factory :consultation do
    patient
    doctor
    health_facility
    timestamp { DateTime.new(2018, 10, 29, 18, 0, 0) }
  end
end
