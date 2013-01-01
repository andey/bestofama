Bestofama::Application.configure do
  config.cache_store = :dalli_store
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true
  config.log_level = :error
  # config.cache_store = :mem_cache_store
  # config.action_controller.asset_host = "http://assets.example.com"
  config.action_mailer.raise_delivery_errors = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
end
