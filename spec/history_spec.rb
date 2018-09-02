describe History do
  describe '.parse_json' do
    it 'message.json からメッセージ履歴を取得できる' do
      expect(History.parse_json['messages']).to be_present
    end
  end
end
