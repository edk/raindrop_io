module RaindropIo
  class Raindrop < RaindropIo::Base
    class << self
      # https://api.raindrop.io/rest/v1/raindrops/{collectionId}
      def raindrops(collection_id)
        response = get("/raindrops/#{collection_id}")
        if response.success? && response["items"]
          response["items"].map { |attributes| Raindrop.new(attributes) }
        else
          RaindropIo::ApiError.new response
        end
      end

      # https://api.raindrop.io/rest/v1/raindrop/{id}
      def raindrop(raindrop_id)
        response = get("/raindrop/#{raindrop_id}")
        if response.success? && response["item"]
          Raindrop.new response["item"]
        else
          RaindropIo::ApiError.new response
        end
      end
    end
  end
end
