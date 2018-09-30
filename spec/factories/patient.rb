FactoryBot.define do
  factory :patient do
    user
    id { 1 }
    identifier { 'PT434323' }
  end

  trait :with_address_and_pre_existing_conditions do
    after(:create) do |patient|
      patient.address = create(:address)
      patient.add_pre_existing_condition(create(:pre_existing_condition))
    end
  end
end
