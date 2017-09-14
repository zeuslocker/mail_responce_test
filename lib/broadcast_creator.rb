require 'rest-client'
require_relative 'authorized_request_headers'
require_relative 'routes'

class BroadcastCreator
  attr_reader :user, :broadcast_name, :broadcast

  def initialize(user, broadcast_name)
    @user = user
    @broadcast_name = broadcast_name
  end

  def perform
    broadcast_attributes = response['data']['attributes']
    @broadcast = Struct.new("Broadcast", *broadcast_attributes.keys).new(*broadcast_attributes.values)
    binding.pry
    RestClient.patch(Routes.broadcasts_setup_url(broadcast.id), broadcast_step_2_json, { Authorization: user.bearer_key, content_type: :json, accept: :json })
  end

  def response
    @response ||= JSON.parse(RestClient.post(Routes.broadcasts_url, broadcast_step_1_json, AuthorizedRequestHeaders.call(user.bearer_key)).body)
  end

  def broadcast_step_1_json
    {
      data:{
        attributes:{
          "name" => "#{broadcast_name}",
          "subject" => nil,
          "send-from-name" => nil,
          "state" => nil,
          "users-tag-rule" => nil,
          "users-tag-excluded-rule" => nil,
          "events-rule" => nil,
          "events-excluded-rule" => nil,
          "segments-rule" => nil,
          "excluded-segments-rule" => nil,
          "leads-total" => nil,
          "deleted-at" => nil,
          "created-at" => nil,
          "updated-at" => nil
        },
        "type" => "broadcasts"
      }
    }.to_json
  end

  def broadcast_step_2_json
    {
      "data" => {
        "id" => "#{broadcast.id}",
        "attributes" => {
          "name" => "#{broadcast_name}",
          "subject" => "subject_text",
          "send-from-name" => " vova_from_name",
          "state" => "drafted",
          "users-tag-rule" => "any",
          "users-tag-excluded-rule" => "any",
          "events-rule" => "any",
          "events-excluded-rule" => "any",
          "segments-rule" => "any",
          "excluded-segments-rule" => "any",
          "leads-total" => nil,
          "deleted-at" => nil,
          "created-at" => "2017-09-14T12:32:17.114Z",
          "updated-at" => "2017-09-14T12:32:17.114Z"
        },
        "relationships" => {
          "user" => {
            "data" => {
              "type" => "users",
              "id" => "#{user.id}"
            }
          },
          "template" => {
            "data" => nil
          },
          "users-sending-email" => {
            "data" => {
              "type" => "users-sending-emails",
              "id" => "22486b76-b12c-4c4e-acc2-5103be88e63d"
            }
          },
          "users-reply-email" => {
            "data" => {
              "type" => "users-sending-emails",
              "id" => "22486b76-b12c-4c4e-acc2-5103be88e63d"
            }
          },
          "broadcast-statistic" => {
            "data" => nil
          },
          "broadcast-schedule-task" => {
            "data" => nil
          },
          "users-tags" => {
            "data" => [

            ]
          },
          "excluded-users-tags" => {
            "data" => [

            ]
          },
          "broadcast-recipients-events" => {
            "data" => [

            ]
          },
          "broadcast-recipients-excluded-events" => {
            "data" => [

            ]
          },
          "global-segments" => {
            "data" => [

            ]
          },
          "excluded-global-segments" => {
            "data" => [

            ]
          }
        },
        "type" => "broadcasts"
      }
    }
  end
end
