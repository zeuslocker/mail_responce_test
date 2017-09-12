require 'rest-client'
require 'json'
require_relative 'routes'

class UserTagsCreator
  attr_reader :bearer_key, :title, :description

  def initialize(bearer_key:, title: SecureRandom.hex(4), description: nil)
    @bearer_key = bearer_key
    @title = title
    @description = description
  end

  def perform
    [ bearer_key,
      JSON.parse(send_request.body)
    ]
  end

  def send_request
    RestClient.post(Routes.user_tags_url, user_tag_json, { Authorization: bearer_key, content_type: :json, accept: :json })
  end

  def user_tag_json
    { "data"=>{
                "attributes"=>{
                                "label"=>title,
                                "description"=>description,
                                "count"=>nil,
                                "import-state"=>nil,
                                "import-total"=>nil,
                                "import-count"=>nil,
                                "deleted-at"=>nil,
                                "created-at"=>nil,
                                "updated-at"=>nil
                              },
                "type"=>"users-tags"
              },
      "users_tag"=>{}
    }.to_json
  end
end
