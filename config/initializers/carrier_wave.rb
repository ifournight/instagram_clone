if Rails.env.test? || Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/google'
    config.fog_credentials = {
      provider: 'Google',
      google_project: ENV['GCLOUD_GOOGLE_PROJECT'],
      google_client_email: ENV['GCLOUD_CLIENT_EMAIL'],
      google_json_key_location: Rails.root.join('.fog/key.json')
    }
    config.fog_directory = ENV['GCLOUD_BUCKET']
  end
end
