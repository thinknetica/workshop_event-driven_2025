class Pays::AnalyseService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    next_message = Pays::BuildMessageService.call(
                     message: message,
                     routing_key: 'pay_analyse')

    RabbitMessages::Send.call(next_message)
  end
end
