# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[8.0]
  enable_extension :pgcrypto

  def change
    create_table(
      :attachments,
      id: :uuid,
      default: -> { 'gen_random_uuid()' },
      comment: 'Почтовые вложения'
    ) do |t|
      t.string :file
      t.string :md5, comment: 'Хэш-сумма md5 для предотвращения изображений-дублей'
      t.boolean :sent, default: false, null: false, comment: 'Файл опубликован в топике'

      t.timestamps
    end
    add_index :attachments, :md5, unique: true
  end
end
