class CreateChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :checks do |t|
      t.text :messages, array: true, default: []
      t.bigint :attachment_id, index: true

      t.timestamps
    end
  end
end
