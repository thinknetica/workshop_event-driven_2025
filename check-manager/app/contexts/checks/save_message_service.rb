class Checks::SaveMessageService
  include Callable
  extend Dry::Initializer

  param :attachment_id
  param :message

  def call
    check = Check.find_or_create_by(attachment_id: attachment_id)
    check.with_lock do
      check.messages << message
      check.save
    end
  end
end
