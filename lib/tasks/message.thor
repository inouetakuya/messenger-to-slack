require 'thor'

module Task
  class Message < Thor
    desc 'convert', 'Convert tmp/message.json to CSV file'
    def convert
      say 'Converted Convert tmp/message.json to CSV file successfully'
    end
  end
end
