class PictureUploader < CarrierWave::Uploader::Base
  # storage :file
  storage :fog
end
