class RabbitBindQueues
  class << self
    def create_for(*workers)
      exchange = channel.exchange(
        Settings.rabbitmq.exchange,
        type: Settings.rabbitmq.exchange_type,
        durable: true
      )

      workers.each do |worker|
        create_queue_for_worker(exchange, worker)
      end
    end

    private

    def channel
      RabbitConnectionManager.channel
    end

    def create_queue_for_worker(exchange, worker_class)
      queue = channel.queue(
        worker_class::QUEUE_NAME,
        durable: true
      )
      worker_class::ACTION_HANDLERS.each_key do |r_key|
        queue.bind(exchange, routing_key: r_key)
      end
    end
  end
end
