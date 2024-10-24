ENV['RAILS_ENV'] ||= 'test'
require 'active_record'
require 'rack/test'
require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Define el método app para Rack::Test
  def app
    Rails.application
  end

  # Configurar ActiveRecord para manejar transacciones manualmente
  config.before(:suite) do
    ActiveRecord::Base.establish_connection
  end

  config.around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  config.mock_with :rspec
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
