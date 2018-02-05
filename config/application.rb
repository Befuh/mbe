require_relative 'boot'

require "rails"
# Pick the frameworks you want:
# require "active_model/railtie"
require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mbe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.generators.system_tests = nil

    config.sequel.schema_format = :sql

    config.sequel.after_connect = proc do
      Sequel::Model.db.loggers << ActiveSupport::Logger.new(STDOUT) if Rails.env.development?
      Sequel::Model.db.extension(:pagination)
      Sequel::Model.db.extension(:pg_array)
      Sequel.extension :pg_array_ops
      Sequel.extension :named_timezones

      Sequel::Model.plugin :validation_helpers
      Sequel::Model.plugin :nested_attributes
      Sequel::Model.plugin :association_dependencies
      Sequel::Model.plugin :timestamps, update_on_create: true
      Sequel::Model.plugin :update_or_create

      Sequel::Model.raise_on_save_failure = false

      Sequel.database_timezone = :utc
      Sequel.tzinfo_disambiguator = proc { |datetime, periods| periods.first }
    end
  end
end
