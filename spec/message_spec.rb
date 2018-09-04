describe Message do
  describe '.iso88591_to_utf8' do
    let(:iso88591_string) { "ã\u0082\u0082ã\u0081¡ã\u0082\u008Dã\u0082\u0093ã\u0081§ã\u0081\u0099ï¼\u0081" }

    it 'ISO-8859-1（latin1）から UTF-8 へ変換できる' do
      expect(Message.iso88591_to_utf8(iso88591_string)).to eq 'もちろんです！'
    end
  end

  let(:message) {
    Message.new(
      sender_name: "inouetakuya",
      timestamp_ms: 1535898453797,
      content: "ã\u0082\u0082ã\u0081¡ã\u0082\u008Dã\u0082\u0093ã\u0081§ã\u0081\u0099ï¼\u0081",
    )
  }

  describe '#sender_name' do
    it { expect(message.sender_name).to eq 'inouetakuya' }
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
          sender_name: "inouetakuya",
          timestamp_ms: 1535898457847,
          content: nil,
        )
      }

      it { expect(message.content).to be_nil }
    end
  end

  describe '#validate_sender_name!' do
    context 'sender_name にマルチバイト文字が含まれているとき' do
      before do
        allow(message).to receive(:sender_name).and_return('いのうえ たくや')
      end

      it '例外が発生する' do
        expect {
          message.validate_sender_name!
        }.to raise_exception(RuntimeError).with_message('sender_name は半角英数字、ピリオド、ハイフン、アンダースコア以外が入っていると Slack インポート時にマッピングできません: いのうえ たくや')
      end
    end

    context 'sender_naem にマルチバイト文字が含まれないとき' do
      it { expect(message.validate_sender_name!).to be_truthy }
    end
  end
end
