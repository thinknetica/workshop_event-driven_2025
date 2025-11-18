# frozen_string_literal: true

class MailManager
  def self.call(&)
    new.call(&)
  end

  def call(&)
    connect
    attachments(emails, &)
    handle_empty_emails
  ensure
    connect.logout
    connect.disconnect
  end

  private

  def connect
    @connect ||= begin
      connection = Net::IMAP.new(Settings.imap.server, Settings.imap.port, true)
      connection.login(Settings.imap.email, Settings.imap.password)
      connection.select('INBOX')
      connection
    end
  end

  def empty_emails_uid
    @empty_emails_uid ||= []
  end

  def emails
    ids = connect.search(['UNSEEN'])

    return if ids.empty?

    connect.fetch(ids, ['UID', 'RFC822'])
  end

  def attachments(emails, &block)
    emails&.each do |email|
      uid = email.attr['UID']
      raw_email_source = email.attr['RFC822']
      message = Mail.read_from_string(raw_email_source)

      empty_emails_uid << uid and next if message.attachments.empty?

      message.attachments.map do |attachment|
        TempfileManager.call(attachment, &block)
      end
    end
  end

  def handle_empty_emails
    empty_emails_uid.each do |uid|
      connect.uid_store(uid, '-FLAGS', [:Seen])
      connect.uid_move(uid, 'errors')
    end
  end
end
