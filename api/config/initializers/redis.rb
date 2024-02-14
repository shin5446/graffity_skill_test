require 'redis'
require 'redis-objects'

Redis::Objects.redis = Redis.new(host: 'redis', port: 6379, db: 0)

