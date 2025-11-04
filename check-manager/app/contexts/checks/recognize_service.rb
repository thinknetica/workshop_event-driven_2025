class Checks::RecognizeService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    next_message = Checks::BuildMessageService.call(
                     message: message,
                     routing_key: 'recognize',
                     reply_to: 'recognized_result')

    RabbitMessages::Send.call(next_message)
  end
end
