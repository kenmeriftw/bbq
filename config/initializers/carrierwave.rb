require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/google'
    config.fog_credentials = {
      provider:               'Google',
      google_project:         'fluted-gateway-312205',
      google_json_key_string: 'GOOGLE_JSON_KEY'
    }

    config.fog_directory  = ENV['GOOGLE_BUCKET_NAME']
  end
end
