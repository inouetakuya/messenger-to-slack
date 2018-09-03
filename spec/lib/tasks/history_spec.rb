describe Task::History do
  describe '#csv' do
    after do
      FileUtils.rm_rf(Dir[File.join(History.dist_dir, '*')])
    end

    it 'exports messages to CSV files' do
      expect {
        Task::History.new.invoke(:csv, [], force: true)
      }.to change { Dir[File.join(History.dist_dir, '**/messages.csv')].size }
    end
  end
end
