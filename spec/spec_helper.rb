ENV['RAILS_ENV'] ||= 'test'
require 'rack/test'
require 'active_record'
require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    Rails.application
  end

  # Establece la conexión con la base de datos antes de la suite de pruebas
  config.before(:suite) do
    ActiveRecord::Base.establish_connection
  end

  # Inicia una transacción para cada prueba
  config.around(:each) do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  # Limpieza de correos antes de cada prueba
  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end

  # Configuración de RSpec para mock y expect
  config.mock_with :rspec
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
