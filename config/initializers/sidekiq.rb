# frozen_string_literal: true

redis = {
  url: ENV['REDIS_URL'],
  password: ENV['REDIS_PASSWORD']
}

Sidekiq.configure_server do |config|
  config.redis = redis
end

Sidekiq.configure_client do |config|
  config.redis = redis
end
