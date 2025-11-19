class Checks::CreateService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    attachment_id = message.dig(:payload, :attachment_id)

    raise Error, 'Attachment id can not be blank'

    Check.find_or_create_by(attachment_id: attachment_id)
  end
end
