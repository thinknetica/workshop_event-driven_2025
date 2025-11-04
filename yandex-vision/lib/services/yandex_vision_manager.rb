# frozen_string_literal: true

class YandexVisionManager
  include HTTParty
  include Callable
  extend Dry::Initializer

  param :path
  option :iam_token, default: proc { `yc iam create-token` }

  base_uri 'https://ocr.api.cloud.yandex.net'

  def call
    url = '/ocr/v1/recognizeText'
    self.class.post(url, options)
  end

  private

  def options
    extname = File.extname(path).gsub('.', '')
    {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{iam_token}",
        'x-data-logging-enabled' => 'true',
        'x-folder-id' => 'b1gdtl2rf29n03bd49nn'
      },
      body: {
        'mimeType': extname,
        'languageCodes': %w[en ru],
        'model': 'page',
        content: Base64.strict_encode64(File.read(path))
      }.to_json
    }
  end
end
