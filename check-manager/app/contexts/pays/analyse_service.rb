class Pays::AnalyseService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    return unless available_send?
    next_message = Pays::BuildMessageService.call(
                     message: message,
                     check_messages: check.messages,
                     routing_key: 'pay_analyse')

    RabbitMessages::Send.call(next_message)
  end

  private

  def available_send?
    check&.messages&.size >= ENV['MESSAGES_SIZE']
  end

  def check
    @check ||= Check.find_by(attachment_id: message.dig(:payload, :attachment_id))
  end
end
