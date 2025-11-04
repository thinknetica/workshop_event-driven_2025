class Checks::RegisterService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    price = message&.dig(:payload, :price)
    file = message&.dig(:payload, :full_path)
    attachment_id = message&.dig(:payload, :attachment_id)

    Check.create!(
      price: price,
      file: file,
      attachment_id: attachment_id
    )
  end
end
