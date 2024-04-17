module RaindropIo
  class Collection < RaindropIo::Base
    # https://api.raindrop.io/rest/v1/collections
    def self.all
      response = get("/collections")
      if response.success? && response["items"]
        response["items"].map { |attributes| Collection.new(attributes) }
      else
        RaindropIo::ApiError.new response
      end
    end

    # https://api.raindrop.io/rest/v1/collection/{id}
    def self.find(collection_id)
      response = get("/collection/#{collection_id}")
      if response.success? && response["item"]
        Collection.new response["item"]
      else
        RaindropIo::ApiError.new response
      end
    end

    def initialize(attributes = {})
      @id = attributes["_id"]
      @attributes = attributes
    end
  end
end
