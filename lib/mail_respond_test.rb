require_relative 'run_options'
require_relative 'import_testing'
require_relative 'broadcast_testing'
require 'pry'

options = RunOptions.call
case options
when ->(h) { h[:import] == true }
  ImportTesting.new(options).perform
when ->(h) { h[:broadcast] == true }
  BroadcastTesting.new(options).perform
end
