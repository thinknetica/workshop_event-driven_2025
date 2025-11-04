require 'sneakers'

Sneakers.configure(
  connection: Bunny.new(RabbitConnectionManager.connection_settings),
  daemonize: false,
  start_worker_delay: 1,
  durable: true,
  ack: true,
  workers: Settings.sneakers.workers,
  threads: Settings.sneakers.threads,
  exchange: Settings.rabbitmq.exchange,
  exchange_type: Settings.rabbitmq.exchange_type,
  retry_timeout: 30,
  retry_max_times: 3,
  timeout_job_after: 60 * 5, # 5 minutes
  prefetch: 1,
  log: Rails.logger
)

Sneakers.logger.level = Rails.logger.level
