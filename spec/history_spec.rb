describe History do
  describe '.export_csv' do
    after do
      FileUtils.rm_rf(Dir[File.join(History.dist_dir, '*')])
    end

    it 'exports messages to CSV files' do
      expect {
        History.export_csv
      }.to change { Dir[File.join(History.dist_dir, '**/messages.csv')].size }
    end

    it 'returns messages count' do
      expect(History.export_csv).to be > 0
    end
  end

  describe '.parse_json' do
    it 'message.json からメッセージ履歴を取得できる' do
      expect(History.parse_json['messages']).to be_present
    end
  end
end
