class Checks < ActiveRecord::Migration[8.0]
  def change
    create_table(
      :checks,
      id: :uuid,
      default: -> { 'gen_random_uuid()' },
      comment: 'Чеки и суммы'
    ) do |t|
      t.uuid :attachment_id
      t.string :price, comment: 'Стоимость в чеке'

      t.timestamps
    end
  end
end
