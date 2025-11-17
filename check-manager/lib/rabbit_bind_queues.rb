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
      if defined? worker_class::QUEUE_DEAD_LETTER
        dead = channel.queue(
          worker_class::QUEUE_DEAD_LETTER,
          durable: true
        )
        dead.bind(exchange, routing_key: worker_class::QUEUE_DEAD_LETTER)
      end

      queue = channel.queue(
        worker_class::QUEUE_NAME,
        worker_class::ARGUMENTS
      )
      worker_class::ACTION_HANDLERS.each_key do |r_key|
        queue.bind(exchange, routing_key: r_key)
      end
    end
  end
end
