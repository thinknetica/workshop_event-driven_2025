class Price::ExtractService
  include Callable
  extend Dry::Initializer

  param :message

  RULES = [
    /СУММА\s*=([.\d]+)/,
    /ИТОГ\s*=([.\d]+)/,
    /НАЛИЧНЫМИ\s*=([.\d]+)/,
    /=([.\d]+)/
  ]

  def call
    RULES.each do |regexp|
      result = message.match(regexp)
      return result[1].to_f if result
    end
    nil
  end
end
