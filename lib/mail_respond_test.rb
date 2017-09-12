require 'optparse'
require 'pry'
require 'rest-client'
require_relative 'run_options'
require_relative 'user_creator'
require_relative 'user_tags_creator'

options = RunOptions.call

users_bearer_keys = UserCreator.new(options[:user_count]).perform

user_with_users_tag_ids = []
users_bearer_keys.each do |bearer_key|
  user_with_users_tag_ids << UserTagsCreator.new(bearer_key: bearer_key).perform
end
