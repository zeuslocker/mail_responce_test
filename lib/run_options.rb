require 'optparse'

class RunOptions
  def self.call
    {}.tap do |result|
      OptionParser.new do |opts|
        opts.banner = "Usage: example.rb [options]"

        opts.on('-u USER_COUNT', '--user_count USER_COUNT', Integer) do |user_count|
          result[:user_count] = user_count
        end

        opts.on('-i', '--import', 'Test leads import') do |import|
          result[:import] = import
        end
      end.parse!
    end
  end
end
