require_relative 'threads_leads_import'
require_relative 'modules/create_users_tags'
require_relative 'broadcast_creator'

class BroadcastTesting
  include CreateUsersTags
  attr_reader :options, :users

  def initialize(options)
    @options = options
  end

  def perform
    create_users_tags
    ThreadsLeadsImport.new(users).perform
    users.each do |user|
      BroadcastCreator.new(user, "user_#{user.id} broadcast").perform
    end
  end

  def users
    @users ||= UserCreator.new(options[:user_count]).perform
  end
end
