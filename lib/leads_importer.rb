require 'SecureRandom'
require 'rest-client'
require_relative 'services/random_string'

class LeadsImporter
  attr_reader :leads_count, :user_tag_ids, :bearer_key

  def initialize(user, user_tag_ids)
    @leads_count = user.leads_count
    @bearer_key = user.bearer_key
    @user_tag_ids = user_tag_ids
    @data = []
  end

  def perform
    RestClient::Request.execute(:method => :post, :url => Routes.leads_import_url, :payload => request_json, :timeout => 9000000, :headers => { Authorization: bearer_key, content_type: :json, accept: :json })
  end

  private

  def request_json
    {
      "data"=>populate_data,
      "meta"=>{"import_type"=>"create",
               "users_tag_ids"=>user_tag_ids
              },
      "lead"=>{}
    }.to_json
  end

  def populate_data
    return @data unless @data.empty?
    leads_count.times do
      @data << lead_hash
    end
    @data
  end

  def lead_hash
    {
      "custom_data"=>{},
      "email"=>"#{SecureRandom.hex(5)}@gmail.com",
      "last_name"=>RandomString.call(3, 12)
    }
  end
end
