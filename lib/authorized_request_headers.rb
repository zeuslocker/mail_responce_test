class AuthorizedRequestHeaders
  def self.call(bearer_key)
    {
      Authorization: bearer_key,
      content_type: :json,
      accept: :json
    }
  end
end
