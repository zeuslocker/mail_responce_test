require 'uri'

class Routes
  class << self
    DEFAULT_HOST = 'http://localhost:3000/'

    def method_missing(meth, *args, &block)
      method_name = meth.to_s

      # join DEFAULT_HOST with appropriate *_path method
      return DEFAULT_HOST + send(method_name.gsub('_url', '_path'), *args) if method_name.to_s.end_with?('_url')
    end

    #---------------------------------

    def users_path
      'users'
    end

    def user_tags_path
      'api/v1/users-tags'
    end

    def leads_import_path
      'api/v1/leads/import'
    end

    def broadcasts_path
      'api/v1/broadcasts'
    end

    def broadcasts_setup_path(id)
      "api/v1/broadcasts/#{id}/setup"
    end
  end

  private_class_method :users_path, :user_tags_path, :broadcasts_path
end
