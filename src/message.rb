class Message
  class << self
    def iso88591_to_utf8(string)
      # datetime - Convert milliseconds to formatted date in Rails - Stack Overflow
      # https://stackoverflow.com/questions/18942816/convert-milliseconds-to-formatted-date-in-rails

      string.chars.map { |char|
        char.encode('ISO-8859-1').ord rescue char.ord
      }.pack('C*').force_encoding('utf-8')
    end
  end

  def initialize(sender_name:, timestamp_ms:, content:)
    @sender_name = sender_name
    @timestamp_ms = timestamp_ms
    @content = content
  end

  def sender_name
    Message.iso88591_to_utf8(@sender_name)
  end

  def timestamp
    @timestamp_ms / 1000
  end

  def content
    Message.iso88591_to_utf8(@content) unless @content.nil?
  end

  def validate_sender_name!
    if sender_name.blank?
      raise'sender_name が入っていません'
    end

    unless sender_name.match(/\A[\w\.\-_]+\z/)
      raise "sender_name は半角英数字、ピリオド、ハイフン、アンダースコア以外が入っていると Slack インポート時にマッピングできません: #{sender_name}"
    end

    true
  end
end
