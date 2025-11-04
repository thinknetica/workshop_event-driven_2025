class Checks::BuildMessageService
  include Callable
  extend Dry::Initializer

  option :check
  option :routing_key

  def call
    {
      action: routing_key,
      payload: {
        full_path: check.file,
        attachment_id: check.attachment_id,
        price: check.price
      },
      created_at: Time.now.utc.to_i,
      routing_key: routing_key
    }
  end
end
