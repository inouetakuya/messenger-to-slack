describe Message do
  describe '.iso88591_to_utf8' do
    let(:iso88591_string) { "ã\u0081\u0084ã\u0081®ã\u0081\u0086ã\u0081\u0088 ã\u0081\u009Fã\u0081\u008Fã\u0082\u0084" }

    it 'ISO-8859-1（latin1）から UTF-8 へ変換できる' do
      expect(Message.iso88591_to_utf8(iso88591_string)).to eq 'いのうえ たくや'
    end
  end

  let(:message) {
    Message.new(
      sender_name: "ã\u0081\u0084ã\u0081®ã\u0081\u0086ã\u0081\u0088 ã\u0081\u009Fã\u0081\u008Fã\u0082\u0084",
      timestamp_ms: 1535898453797,
      content: "ã\u0082\u0082ã\u0081¡ã\u0082\u008Dã\u0082\u0093ã\u0081§ã\u0081\u0099ï¼\u0081",
    )
  }

  describe '#sender_name' do
    it { expect(message.sender_name).to eq 'いのうえ たくや' }
  end

  describe '#timestamp' do
    it { expect(message.timestamp.to_s).to match /\A\d{10,}\z/ }
  end

  describe '#content' do
    context 'content is present' do
      it { expect(message.content).to eq 'もちろんです！' }
    end

    context 'content is nil' do
      let(:message) {
        Message.new(
          sender_name: "ã\u0081\u0084ã\u0081®ã\u0081\u0086ã\u0081\u0088 ã\u0081\u009Fã\u0081\u008Fã\u0082\u0084",
          timestamp_ms: 1535898457847,
          content: nil,
        )
      }

      it { expect(message.content).to be_nil }
    end
  end
end
