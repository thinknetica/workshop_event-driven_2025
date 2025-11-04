class Checks::RecognizeService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    RabbitMessages::Send.new(next_message).call
  end

  private

  def next_message
    Checks::BuildMessageService.call(
      message: message,
      recognize_text: recognize_text,
      routing_key: message[:reply_to])
  end

  def recognize_text
    s3_key = message.dig(:payload, :full_path)
    TempfileManager.call(file_content(s3_key), s3_key) do |path|
      `tesseract #{path} stdout --oem 1 -l rus`
    end
  end

  def file_content(s3_key)
    s3 = Aws::S3::Client.new
    resp = s3.get_object(
      bucket: ENV.fetch('S3_BUCKET_NAME'),
      key: s3_key)
    resp.body.read.force_encoding(Encoding::UTF_8)
  end
end
