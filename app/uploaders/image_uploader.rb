# .frozen
class ImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir

  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  def filename
    Time.now.utc.to_s
  end
end
