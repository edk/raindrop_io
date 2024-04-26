module RaindropIo
  # Raindrop class (a bookmark)
  #
  # @see https://developer.raindrop.io/v1/raindrops
  class Raindrop < RaindropIo::Base
    class << self
      def default_page_size
        25
      end

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
          drops = response.parse["items"].map { |attributes| Raindrop.new(attributes) }
          total = response.parse["count"]
          {total: total, items: drops}
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

      # Update raindrop
      # PUT https://api.raindrop.io/rest/v1/raindrop/{id}
      def update(raindrop_id, attributes)
        # strip out any attributes not listed in the docs
        allowed = %w[created lastUpdate pleaseParse order important tags media
          cover collection type excerpt title link highlights extra_data]
        # extra_data is a hash of key-value pairs is a catch all for unkown attributes,
        # since we don't know about them, we'll not pass them to the API for now.
        attrs = attributes.except(*allowed)[:data]
        response = put("/raindrop/#{raindrop_id}", json: attrs)
        if response.status.success? && response.parse["item"]
          Raindrop.new response.parse["item"]
        else
          RaindropIo::ApiError.new response
        end
      end

      # Remove raindrop
      # DELETE https://api.raindrop.io/rest/v1/raindrop/{id}

      # Upload file
      # PUT https://api.raindrop.io/rest/v1/raindrop/file
      # Make sure to send PUT request with multipart/form-data body

      # Upload cover
      # PUT https://api.raindrop.io/rest/v1/raindrop/{id}/cover
      # PNG, GIF or JPEG

      # Suggest collection and tags for existing bookmark
      # GET https://api.raindrop.io/rest/v1/raindrop/{id}/suggest
      def suggest(raindrop_id)
        response = get("/raindrop/#{raindrop_id}/suggest")
        if response.status.success? && response.parse["item"]
          response.parse["item"]
        else
          RaindropIo::ApiError.new response
        end
      end
    end # end class << self
  end
end
