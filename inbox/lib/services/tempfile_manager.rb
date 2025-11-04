# frozen_string_literal: true

class TempfileManager
  def self.call(attachment)
    extname = File.extname(attachment.filename)
    base_name = File.basename(attachment.filename, extname)

    tempfile = Tempfile.new([base_name, extname], Dir.tmpdir, encoding: 'ascii-8bit')

    tempfile.write(attachment.body.decoded)
    tempfile.rewind

    yield tempfile, Digest::MD5.hexdigest(attachment.body.decoded)

    tempfile.close
    File.unlink(tempfile.path)
  end
end
