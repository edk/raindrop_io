module RaindropIo
  class User < RaindropIo::Base
    class << self
      # @see https://api.raindrop.io/rest/v1/user
      def current_user
        response = get("/user")
        if response.status.success? && response.parse["result"] == true
          User.new response.parse["user"]
        else
          RaindropIo::ApiError.new response
        end
      end

      # Get user by name
      # @see https://api.raindrop.io/rest/v1/user/{name}
      def find_by_name(name)
        response = get("/user/#{ERB::Util.url_encode(name)}")
        if response.status.success? && response.parse["result"] == true
          User.new response.parse["user"]
        else
          RaindropIo::ApiError.new response
        end
      end
    end # end class << self

    def collections
      @groups[0]["collections"].map { |id| RaindropIo::Collection.find(id) }
    end

    # TODO:
    # update user
    # PUT https://api.raindrop.io/rest/v1/user
    # Connect social network account
    # GET https://api.raindrop.io/rest/v1/user/connect/{provider}
    # Disconnect social network account
    # GET https://api.raindrop.io/rest/v1/user/connect/{provider}/revoke
  end
end
