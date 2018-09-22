ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'factory_bot'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.include FactoryBot::Syntax::Methods
  config.include APIHelper

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.after(:each) do |example|
    Sequel.application_timezone = nil
    Sequel.typecast_timezone = nil
  end

  config.around(:each) do |example|
    Sequel::Model.db.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end

  FactoryBot.define do
    to_create { |instance| instance.save }
  end
end
