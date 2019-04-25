FactoryBot.define do
  factory :patient do
    user
  end

  trait :with_address_and_pre_existing_conditions do
    after(:create) do |patient|
      patient.address = create(:address)
      disease = create(:disease)
      patient.pre_existing_conditions << create(:pre_existing_condition, disease: disease)
    end
  end
end
