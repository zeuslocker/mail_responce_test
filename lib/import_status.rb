require 'rest-client'

class ImportStatus
  attr_reader :bearer_key, :user_tag_id, :user_index

  def initialize(bearer_key, user_tag_id, user_index)
    @bearer_key = bearer_key
    @user_tag_id = user_tag_id
    @user_index = user_index
  end

  def perform
    return "User ##{user_index} hasnt user_tags" if user_tag.nil?
    "User ##{user_index} #{user_tag.fetch('import-count', 'NIL')}/#{user_tag.fetch('import-total', 'NIL')}"
  end

  def user_tag
    JSON.parse(responce.body)['data']&.first&.fetch('attributes')
  end

  def responce
    @responce ||= RestClient::Request.execute(:method => :get, :url => Routes.user_tags_url, :timeout => 9000000, :headers => { Authorization: bearer_key, content_type: :json, accept: :json })
  end
end
