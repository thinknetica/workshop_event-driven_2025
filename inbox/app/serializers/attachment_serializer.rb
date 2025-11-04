# frozen_string_literal: true

class AttachmentSerializer
  include Alba::Resource

  attribute :action do |_attachment|
    'attachment_registered'
  end

  attribute :created_at do |_attachment|
    Time.now.utc.to_i
  end

  attribute :routing_key do |_attachment|
    Settings.rabbitmq.routing_key
  end

  nested_attribute :payload do
    attribute :attachment_id, &:id
    attribute :file do |attachment|
      attachment.file.identifier
    end
    attribute :full_path do |attachment|
      attachment.file.path
    end
    attributes :md5
    attribute :created_at do |attachment|
      attachment.created_at.utc.to_i
    end
  end
end
