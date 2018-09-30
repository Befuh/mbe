class Patient < Sequel::Model
  one_through_one :address

  many_to_one :user

  many_to_many :pre_existing_conditions
  add_association_dependencies pre_existing_conditions: :nullify

  def validate
    super
    validates_presence [:identifier, :user_id]
    validates_unique :identifier
    validates_unique :user_id
  end
end
