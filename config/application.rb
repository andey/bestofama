require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Bestofama
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.secret_key_base = 'c1ad4b219d69cca4970a0ab0b2e543a732226274bc655a53383f7cf7e437aebb6c48d629df92401967962ef93add4589cb4f3f81a0e0ad969d00b474c78b5e01'
    config.i18n.enforce_available_locales = false
  end
end
