# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_02_143305) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "checks", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Чеки и суммы", force: :cascade do |t|
    t.uuid "attachment_id"
    t.string "price", comment: "Стоимость в чеке"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rabbit_messages", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "Логгирование RabbitMQ-сообщений", force: :cascade do |t|
    t.string "action", null: false, comment: "Тип/экшен сообщения"
    t.jsonb "data", comment: "Структура сообщения, которая будет передаваться следующему микросервису"
    t.boolean "success", default: true, null: false, comment: "Сообщение обработалось?"
    t.string "error_message", comment: "Сообщение об ошибке"
    t.text "error_backtrace", comment: "Стектрейс ошибки"
    t.string "direction", default: "income", comment: "Направление сообщения"
    t.string "routing_key", comment: "Ключ маршрутизации"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action"], name: "index_rabbit_messages_on_action"
    t.index ["created_at"], name: "index_rabbit_messages_on_created_at"
  end
end
