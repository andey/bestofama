Bestofama::Application.configure do

  config.cache_classes = false
  config.whiny_nils = true
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.active_record.mass_assignment_sanitizer = :strict
  config.active_record.auto_explain_threshold_in_seconds = 0.5
  config.assets.compress = false
  config.assets.debug = true
  config.log_level = :warn

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
