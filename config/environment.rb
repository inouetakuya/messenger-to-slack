require 'pry'

ENV['TIME_ZONE'] ||= 'Etc/UTC'
Time.zone_default = Time.find_zone!(ENV['TIME_ZONE'])

module MessengerToSlack
  ROOT_PATH = File.expand_path('../', __dir__)
end

Dir[
  File.join(__dir__, '../lib/tasks/**/*.thor'),
].each do |file|
  load file
end
