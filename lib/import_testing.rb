require 'pry'
require 'rest-client'
require_relative 'user_creator'
require_relative 'user_tags_creator'
require_relative 'leads_importer'
require_relative 'import_status'
require_relative 'services/sample_leads_count'
require_relative 'modules/create_users_tags'

class ImportTesting
  include CreateUsersTags # create_users

  attr_reader :user_with_users_tag_ids, :threads, :count_index, :options

  def initialize(options)
    @user_with_users_tag_ids =[]
    @threads = []
    @count_index = 0
    @options = options
  end

  def perform
    create_users_tags
    create_and_start_threads
    p "\n SUCCESS \n"
    import_status_loop
  end

  def import_status_loop
    loop do
      check_import_status
      puts "\n-----ITERATION-----\n"
      sleep(1)
      exit if gets.chomp == 'q'
    end
  end

  def check_import_status
    threads = []
    users.each do |user|
      threads << Thread.new do
        p ImportStatus.new(user.bearer_key, user.user_tag_ids[0], user.id).perform
      end
    end
    threads.each(&:join)
  end

  def create_and_start_threads
    users.each do |user|
      threads << leads_import_thread(user)
    end
    threads.each(&:join)
  end

  def leads_import_thread(user)
    Thread.new do
      user.leads_count = SampleLeadsCount.call
      @count_index += 1
      p "\nUser #{count_index} leads count: #{user.leads_count}\n"
      LeadsImporter.new(user, user.user_tag_ids).perform
    end
  end

  def users
    @users ||= UserCreator.new(options[:user_count]).perform
  end
end
