class Checks::TesseractService
  include Callable
  extend Dry::Initializer

  param :message

  def call
    file_path = message.dig(:payload, :file_path)
    file = download_file(file_path)
    response = send_to_tesseract(file)

    raise Error, 'Tesseract problem' unless response.is_a?(Net::HTTPSuccess)

    Checks::SaveMessageService.call(message.dig(:payload, :attachment_id), response.body)
  end

  private


  def service

  end

  def download_file(url)
    uri = URI.parse(url)

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)

      http.request(request) do |response|
        raise Error, "Failed to download file: #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)

        temp_file = Tempfile.new(["downloaded_file_#{Time.current.to_i}", File.extname(uri.path)])
        temp_file.binmode

        response.read_body do |chunk|
          temp_file.write(chunk)
        end

        temp_file.close
        return temp_file
      end
    end
  end

  def send_to_tesseract(file)
    uri = URI.parse(ENV['TESSERACT_URL'])

    file_content = File.binread(file.path)

    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.body = file_content

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
  end
end
