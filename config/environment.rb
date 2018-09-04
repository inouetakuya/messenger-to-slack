require 'active_support'
require 'active_support/core_ext'
require 'pry'

module MessengerToSlack
  ROOT_PATH = File.expand_path('../', __dir__)
end

Dir[
  File.join(__dir__, '../lib/**/*.rb'),
  File.join(__dir__, '../src/**/*.rb'),
].each do |file|
  require file
end

Dir[
  File.join(__dir__, '../lib/tasks/**/*.thor'),
].each do |file|
  load file
end
