# frozen_string_literal: true

redis = {
  url: ENV['REDIS_URL'],
  password: ENV['REDIS_PASSWORD'],
  ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
}

Sidekiq.configure_server do |config|
  config.redis = redis
end

Sidekiq.configure_client do |config|
  config.redis = redis
end

# configure cron jobs from schedule file
schedule_file = 'config/schedule.yml'
Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
