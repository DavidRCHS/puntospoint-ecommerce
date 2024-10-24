require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler) && Bundler.respond_to?(:require)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(:default, Rails.env)
end

module PuntospointEcommerce
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
  end
end
