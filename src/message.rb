require 'miyabi'

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
    @_sender_name ||= begin
      name = Message.iso88591_to_utf8(@sender_name)
      name.match(/\A[\w\.\-_]+\z/) ? name : convert_to_roman(name)
    end
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

  private

  def convert_to_roman(name)
    # ネットワークを使い、とても時間がかかるため、可能であれば、事前に message.json を置換しておいたほうがよい
    name.to_kanhira.to_roman

  rescue Mechanize::ResponseCodeError
    # pry(main)> "いのうえ たくや".to_kanhira
    #
    # Mechanize::ResponseCodeError: 403 => Net::HTTPForbidden for https://yomikatawa.com/kanji/%E3%81%84%E3%81%AE%E3%81%86%E3%81%88%20%E3%81%9F%E3%81%8F%E3%82%84 -- unhandled response
    # from /Users/inouetakuya/src/github.com/inouetakuya/messenger-to-slack/vendor/bundle/ruby/2.5.0/gems/mechanize-2.7.5/lib/mechanize/http/agent.rb:323:in `fetch'
    #
    # となるので is_kanji? メソッドで判定してから to_kanhira を使おうと考えたが、
    #
    # pry(main)> "井上 たくや".is_kanji?
    # => false
    #
    # pry(main)> "井上 たくや".to_roman
    # => "takuya"
    #
    # となるため、やむを得ず例外キャッチ

    name.to_roman
  end
end
