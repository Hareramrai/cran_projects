sidekiq_redis_url = Rails.application.secrets.sidekiq_redis_url 

Sidekiq.configure_server do |config|
  config.redis = { url: sidekiq_redis_url }

  # Schedules
  schedule_file = "config/sidekiq_schedule.yml"

  if File.exist?(schedule_file) && !File.zero?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: sidekiq_redis_url }
end