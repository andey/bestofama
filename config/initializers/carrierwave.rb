# config/initializers/carrierwave.rb
#
# Used by paperclip to upload avatars to Amazon AWS S3

CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/"
  config.storage = :fog
  config.permissions = 0666
  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET'],
      :path_style => true
  }
  config.fog_directory = 's3.bestofama.com'
end