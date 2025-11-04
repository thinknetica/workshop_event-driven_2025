# frozen_string_literal: true

class AttachmentUploader < CarrierWave::Uploader::Base
  storage :aws

  def filename
    "#{secure_token}.#{file.extension}"
  end

  def store_dir
    "#{model.class.to_s.underscore}/#{DateTime.current.to_date}"
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
