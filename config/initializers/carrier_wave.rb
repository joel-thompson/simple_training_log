if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => Rails.application.secrets.s3_access_key,
      :aws_secret_access_key => Rails.application.secrets.s3_secret_key
    }
    config.fog_directory     =  Rails.application.secrets.s3_bucket
  end
end
