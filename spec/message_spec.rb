describe Message do
  describe '.iso88591_to_utf8' do
    let(:iso88591_string) { "ã\u0081\u0084ã\u0081®ã\u0081\u0086ã\u0081\u0088 ã\u0081\u009Fã\u0081\u008Fã\u0082\u0084" }

    it 'ISO-8859-1（latin1）から UTF-8 へ変換できる' do
      expect(Message.iso88591_to_utf8(iso88591_string)).to eq 'いのうえ たくや'
    end
  end
end
