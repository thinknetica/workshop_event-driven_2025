credentials = Aws::Credentials.new(
  ENV.fetch('S3_ACCESS_KEY_ID'),
  ENV.fetch('S3_SECRET_ACCESS_KEY'))

Aws.config.update(
  endpoint: ENV.fetch('S3_URL'),
  region: ENV.fetch('S3_REGION'),
  credentials: credentials)
