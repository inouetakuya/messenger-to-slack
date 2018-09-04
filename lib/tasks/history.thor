require 'thor'

module Task
  class History < Thor
    desc 'csv', 'Convert tmp/message.json to CSV file'
    method_option :channel, type: :string, desc: 'Channel name of Slack'
    method_option :force, type: :boolean, default: false, desc: 'Skip asking questions'
    def csv
      unless options[:force] || yes?("Convert tmp/message.json to CSV file? (y/N)", :yellow)
        return say 'Task is aborted'
      end

      say 'Converting tmp/message.json to CSV file ...'

      if options[:channel]
        ::History.export_csv(channel: options[:channel].match /\A#/ ? options[:channel] : '#' + options[:channel])
      else
        ::History.export_csv
      end

      say 'Converted tmp/message.json to CSV file successfully'
    end
  end
end
