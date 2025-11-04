# frozen_string_literal: true

namespace :upload do
  desc 'Загрузка чека в S3-хранилище'
  task check: :environment do
    attach = Attachment.new
    File.open(Rails.root.join('spec/fixtures/check001.jpeg')) do |f|
      attach.file = f
    end
    attach.save!
  end
end
