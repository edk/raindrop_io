module RaindropIo
  class User < RaindropIo::Base
    class << self
      # https://api.raindrop.io/rest/v1/user
      def current_user
        response = get("/user")
        if response.success? && response["result"] == true
          User.new response["user"]
        else
          RaindropIo::ApiError.new response
        end
      end

      # get user by name
      # https://api.raindrop.io/rest/v1/user/{name}
      def find_by_name(name)
        response = get("/user/#{ERB::Util.url_encode(name)}")
        if response.success? && response["result"] == true
          User.new response["user"]
        else
          RaindropIo::ApiError.new response
        end
      end
    end

    def collections
      @groups[0]["collections"].map { |id| RaindropIo::Collection.find(id) }
    end
  end
end
