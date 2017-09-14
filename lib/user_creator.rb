require 'rest-client'
require 'json'
require_relative 'routes'
require_relative 'models/user'

class UserCreator
  attr_reader :user_count
  BEARER = 'Bearer'
  DEFAULT_PASSWORD = 'qwerty1111'

  def initialize(user_count)
    @user_count = user_count
    @index = 0
  end

  def perform
    [].tap do |result|
      user_count.times do
        result << User.new(@index, "#{BEARER} #{JSON.parse(send_request.body)['access_token']}")
        @index += 1
      end
    end
  end

  private

  def send_request
    RestClient.post(Routes.users_url, random_user_json, { content_type: :json, accept: :json })
  end

  def random_user_json
    {
      user: {
        email: random_user_email,
        password: DEFAULT_PASSWORD,
        passwordConfirmation: DEFAULT_PASSWORD
      },
      registration: {
        email: random_user_email,
        password: DEFAULT_PASSWORD,
        passwordConfirmation: DEFAULT_PASSWORD
      }
    }
  end

  def random_user_email
    "#{@index}_#{SecureRandom.hex(3)}@gmail.com"
  end
end
