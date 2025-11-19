class Pays::BuildMessageService
  include Callable
  extend Dry::Initializer

  option :message
  option :routing_key
  option :check_messages

  def call
    {
      action: routing_key,
      payload: {
        file: message.dig(:payload, :file),
        full_path: message.dig(:payload, :full_path),
        attachment_id: message.dig(:payload, :attachment_id),
        created_at: message.dig(:payload, :created_at),
        message: check_messages
      },
      created_at: Time.now.utc.to_i,
      routing_key: routing_key
    }
  end
end
