require 'resque/tasks'

namespace :resque do
  task :setup => :environment do
    Resque.redis = Redis.new(host: 'localhost', port: 6379)
  end
end