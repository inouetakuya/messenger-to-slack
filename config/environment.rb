require 'pry'

module MessengerToSlack
  ROOT_PATH = File.expand_path('../', __dir__)
end

Dir[
  File.join(__dir__, '../lib/tasks/**/*.thor'),
].each do |file|
  load file
end
