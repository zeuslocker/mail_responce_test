class BroadcastTesting
  include CreateUsers # create_users

  attr_reader :options, :users

  def initialize(options)
    @options = options
  end

  def perform

  end
end
