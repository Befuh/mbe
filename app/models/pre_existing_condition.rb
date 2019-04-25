class PreExistingCondition < ApplicationRecord
  belongs_to :patient
  belongs_to :disease

  attribute :treated, :boolean, default: false
end
