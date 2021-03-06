Bestofama::Application.configure do

  config.cache_classes = false
  #config.whiny_nils = true
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  #config.active_record.mass_assignment_sanitizer = :strict
  #config.active_record.auto_explain_threshold_in_seconds = 0.5
  config.assets.compress = false
  config.assets.debug = nil
  config.assets.logger = nil
  config.log_level = :debug
  config.eager_load = false

  # Default paperclip config
  config.paperclip_defaults = {
      :storage => :s3,
      :path => "/entities/avatars/:id_partition/:style/:basename.:extension",
      :s3_protocol => :https,
      :s3_credentials => {
          :bucket => 's3.bestofama.com',
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      }
  }
end
