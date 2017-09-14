User = Struct.new(:id, :bearer_key, :user_tag_ids, :leads_count) do
  def initialize(id, bearer_key, user_tag_ids = [], leads_count = 0)
    super
  end
end
