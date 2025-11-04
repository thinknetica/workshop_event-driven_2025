# frozen_string_literal: true

class TempfileManager
  def self.call(file_content, path)
    extname = File.extname(path)
    base_name = File.basename(path, extname)

    tempfile = Tempfile.new([base_name, extname], Dir.tmpdir, encoding: 'ascii-8bit')

    tempfile.write(file_content)
    tempfile.rewind

    text = yield tempfile.path

    tempfile.close
    File.unlink(tempfile.path)

    text
  end
end
