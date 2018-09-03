require 'csv'
require 'json'

class History
  class << self
    def export_csv(channel_name: 'general')
      current = Time.current

      FileUtils.mkdir_p(csv_dir(current: current))

      CSV.open(csv_path(current: current), 'w') do |csv|
        parse_json['messages'].each do |data|
          message = Message.new(
            sender_name: data['sender_name'],
            timestamp_ms: data['timestamp_ms'],
            content: data['content'],
          )

          if message.content.present?
            csv << [message.timestamp, channel_name, message.sender_name, message.content]
          end
        end
      end

      parse_json['messages'].size

    rescue => exception
      FileUtils.rm_rf(csv_dir(current: current)) if Dir.exist?(csv_dir(current: current))
      raise exception
    end

    def parse_json
      @json_data ||= JSON.parse(File.open(json_path).read)
    end

    def dist_dir
      if ENV['ENV'] == 'test'
        File.join(MessengerToSlack::ROOT_PATH, 'spec/dist')
      else
        File.join(MessengerToSlack::ROOT_PATH, 'dist')
      end
    end

    private

    def csv_dir(current: Time.current)
      File.join(dist_dir, current.strftime('%Y%m%d%H%M%S'))
    end

    def csv_path(current: Time.current)
      File.join(csv_dir(current: current), 'messages.csv')
    end

    def json_path
      if ENV['ENV'] == 'test'
        File.join(MessengerToSlack::ROOT_PATH, 'spec/fixtures/message.json')
      else
        File.join(MessengerToSlack::ROOT_PATH, 'tmp/message.json')
      end
    end
  end
end
