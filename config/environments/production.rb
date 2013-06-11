Bestofama::Application.configure do

  # use cache servers by iron.io/cache
  config.cache_store = :iron_cache, {project_id: '50f845e3d429792719001884', token: 'TXC_SH3Iq-xIjr2plscWFHKcF7Q'}
  config.cache_classes = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true
  config.assets.logger = false
  config.log_level = :error
  config.action_mailer.raise_delivery_errors = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :silence
  config.eager_load = true

  # Default paperclip config
  config.paperclip_defaults = {
      :storage => :s3,
      :path => "/entities/avatars/:id_partition/:style/:basename.:extension",
      :url => ":s3_alias_url",
      :s3_host_alias => "s3.bestofama.com",
      :s3_credentials => {
          :bucket => 's3.bestofama.com',
          :access_key_id => ENV['S3_KEY'],
          :secret_access_key => ENV['S3_SECRET']
      }
  }
end
