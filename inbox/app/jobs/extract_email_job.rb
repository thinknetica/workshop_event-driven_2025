# frozen_string_literal: true

class ExtractEmailJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    MailManager.call do |tmpfile, md5|
      attach = Attachment.new(file: tmpfile, md5: md5)
      attach.save if attach.valid?
    end
  end
end
