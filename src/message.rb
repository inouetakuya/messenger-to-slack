class Message
  class << self
    def iso88591_to_utf8(string)
      string.chars.map { |char|
        char.encode('ISO-8859-1').ord rescue char.ord
      }.pack('C*').force_encoding('utf-8')
    end
  end

  def initialize(sender_name:, timestamp_ms:, content:)
    @sender_name = sender_name
    @timestamp_ms = @timestamp_ms
    @content = content
  end
end
