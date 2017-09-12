require 'SecureRandom'

class LeadsImporter
  attr_reader :leads_count, :data

  def initialize(leads_count, user_tag_ids, bearer_key)
    @leads_count = leads_count
    @data = []
  end

  def perform

  end

  private

  def request_json
    {
      "data"=>populate_data,
      "meta"=>{"import_type"=>"create",
      "users_tag_ids"=>user_tag_ids},
      "lead"=>{}
    }
  end

  def populate_data
    leads_count.times do
      @data << lead_hash
    end
    @data
  end

  def lead_hash
    { "custom_data"=>{}, "email"=>"#{SecureRandom.hex(5)}@gmail.com", "last_name"=>RandomString.call(3, 12) }
  end
end
