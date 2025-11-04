# frozen_string_literal: true

class SentAttachmentJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    RabbitmqManager.call do |exchange|
      Attachment.not_sent.find_each do |attach|
        data = AttachmentSerializer.new(attach).serialize
        exchange.publish(data, routing_key: Settings.rabbitmq.routing_key)
        attach.update_columns(sent: true)
      end
    end
  end
end
