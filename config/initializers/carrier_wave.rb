if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/google'                        # required
    config.fog_credentials = {
      provider:                         'Google',
      google_storage_access_key_id:     ENV['GCLOUD_ACCESS_ID'],
      google_storage_secret_access_key: ENV['GCLOUD_SECRET_KEY']
    }
    config.fog_directory = ENV['GCLOUD_BUCKET']
  end
end
