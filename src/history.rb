require 'json'

class History
  class << self
    def parse_json
      JSON.parse(File.open(json_path).read)
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
