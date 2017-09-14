module CreateUsersTags
  # _MODULE CONTEXT_
  # @users_bearer_keys = ['Bearer df4...', 'Bearer gff3...', ...]
  # @user_with_users_tag_ids = []

  def create_users_tags
    users.each_with_index do |user|
      user.user_tag_ids << UserTagsCreator.new(bearer_key: user.bearer_key).perform[1]['data']['id']
    end
  end
end
