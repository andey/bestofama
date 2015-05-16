Bestofama::Application.configure do

  # use cache servers by iron.io/cache
  if ENV["MEMCACHEDCLOUD_SERVERS"]
    config.cache_store = :dalli_store, ENV["MEMCACHEDCLOUD_SERVERS"].split(','), {:username => ENV["MEMCACHEDCLOUD_USERNAME"], :password => ENV["MEMCACHEDCLOUD_PASSWORD"]}
    config.cache_classes = true
  end

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true
  config.assets.logger = false
  config.log_level = ENV['LOG_LEVEL']
  config.action_mailer.raise_delivery_errors = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :silence
  config.eager_load = true

  # Default paperclip config
  config.paperclip_defaults = {
      :storage => :s3,
      :path => "/entities/avatars/:id_partition/:style/:basename.:extension",
      :s3_protocol => :https,
      :s3_credentials => {
          :bucket => 's3.bestofama.com',
          :access_key_id => ENV['S3_KEY'],
          :secret_access_key => ENV['S3_SECRET']
      }
  }
end
