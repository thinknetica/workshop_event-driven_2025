class Checks::RegisterService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    price = message&.dig(:payload, :price)
    attachment_id = message&.dig(:payload, :attachment_id)

    Check.create!(
      price: price,
      attachment_id: attachment_id
    )
  end
end
