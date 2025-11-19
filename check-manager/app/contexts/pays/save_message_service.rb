class Pays::SaveMessageService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    attachment_id = message.dig(:payload, :attachment_id)

    raise Error, 'Attachment id can not be blank'

    Checks::SaveMessageService.call(attachment_id, message.dig(:payload, :message))
  end
end
