require 'optparse'

class RunOptions
  def self.call
    {}.tap do |result|
      OptionParser.new do |opts|
        opts.banner = "Usage: example.rb [options]"

        opts.on('-u USER_COUNT', '--user_count USER_COUNT', Integer) do |user_count|
          result[:user_count] = user_count
        end

        opts.on('-r LEAD_COUNT', '--random LEAD_COUNT', String, 'Generate random leads list') do |random|
          result[:random] = random.include?('[') ? random[1..-2].split(',').map(&:to_i) : random.to_i
        end
      end.parse!
    end
  end
end
