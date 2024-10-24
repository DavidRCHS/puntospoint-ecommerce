require 'resque'

Resque.redis = Redis.new(host: 'localhost', port: 6379)