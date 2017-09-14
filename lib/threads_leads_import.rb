require_relative 'leads_importer'

class ThreadsLeadsImport
  attr_reader :users, :threads

  def initialize(users)
    @users = users
    @threads = []
  end

  def perform
    users.each do |user|
      user.leads_count = SampleLeadsCount.call
      threads << import_thread(user)
    end
    threads.each(&:join)
  end

  def import_thread(user)
    Thread.new do
      LeadsImporter.new(user, user.user_tag_ids).perform
      p "\nUser #{user.id} leads count: #{user.leads_count}\n"
    end
  end
end
