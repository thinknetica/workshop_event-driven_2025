# frozen_string_literal: true

class RabbitmqManager
  attr_reader :connection, :channel

  def self.call(&)
    new.call(&)
  end

  def call
    exchange = connect
    yield(exchange)
    close
  end

  private

  def connect
    @connection = Bunny.new(Settings.rabbitmq.to_hash)
    connection.start
    @channel = connection.create_channel
    queue = channel.queue(Settings.rabbitmq.outbox_queue, durable: true)
    exchange = channel.exchange(
      Settings.rabbitmq.exchange,
      type: Settings.rabbitmq.exchange_type,
      durable: true
    )
    queue.bind(exchange, routing_key: Settings.rabbitmq.routing_key)

    exchange
  end

  def close
    channel.close
    connection.close
  end
end
