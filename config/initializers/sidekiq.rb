Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0', network_timeout: 5 }
end