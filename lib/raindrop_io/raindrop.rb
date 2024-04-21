module RaindropIo
  # Raindrop class (a bookmark)
  #
  # @see https://developer.raindrop.io/v1/raindrops
  class Raindrop < RaindropIo::Base
    class << self
      # Get multiple raindrops in a collection
      #
      # @param collection_id [String] The ID of the collection
      # @param options [Hash] Additional query parameters
      # @option options [String] :sort The sort order
      # @option options [Integer] :perpage The number of raindrops per page
      # @option options [Integer] :page The page number
      # @option options [String] :search The search query
      # @return [Array<RaindropIo::Raindrop>] An array of Raindrop objects
      def raindrops(collection_id, options = {})
        response = get("/raindrops/#{collection_id}", options)
        if response.status.success? && response.parse["items"]
          response.parse["items"].map { |attributes| Raindrop.new(attributes) }
        else
          RaindropIo::ApiError.new response
        end
      end

      # Get raindrop
      # @see https://api.raindrop.io/rest/v1/raindrop/{id}
      def raindrop(raindrop_id)
        response = get("/raindrop/#{raindrop_id}")
        if response.status.success? && response.parse["item"]
          Raindrop.new response.parse["item"]
        else
          RaindropIo::ApiError.new response
        end
      end
    end # end class << self
  end
end
