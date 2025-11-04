# frozen_string_literal: true

class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader
  scope :not_sent, -> { where(sent: false) }
  validates :md5, uniqueness: true
end
