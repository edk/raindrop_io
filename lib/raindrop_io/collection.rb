module RaindropIo
  # System collections
  # Every user have several system non-removable collections. They are not contained in any API responses.
  # _id | Description
  # ----|------------
  # -1  | "Unsorted" collection
  # -99 | "Trash" collection

  class Collection < RaindropIo::Base
    class << self
      # Get root collections
      # GET https://api.raindrop.io/rest/v1/collections
      def all
        response = get("/collections")
        if response.success? && response["items"]
          response["items"].map { |attributes| Collection.new(attributes) }
        else
          RaindropIo::ApiError.new response
        end
      end

      # Get child collections
      # GET https://api.raindrop.io/rest/v1/collections/childrens
      def childrens
        response = get("/collections/childrens")
        if response.success? && response["items"]
          response["items"].map { |attributes| Collection.new(attributes) }
        else
          RaindropIo::ApiError.new response
        end
      end

      # Get collection
      # https://api.raindrop.io/rest/v1/collection/{id}
      def find(collection_id)
        response = get("/collection/#{collection_id}")
        if response.success? && response["item"]
          Collection.new response["item"]
        else
          RaindropIo::ApiError.new response
        end
      end

      # Get system collections count
      # GET https://api.raindrop.io/rest/v1/user/stats
      def stats
        response = get("/user/stats")
        if response.success?
          response
        else
          RaindropIo::ApiError.new response
        end
      end

      # Create collection
      # POST https://api.raindrop.io/rest/v1/collection
      # Create a new collection

      # Update collection
      # PUT https://api.raindrop.io/rest/v1/collection/{id}
      # Update an existing collection

      # Upload cover
      # PUT https://api.raindrop.io/rest/v1/collection/{id}/cover
      # It's possible to upload cover from desktop. PNG, GIF and JPEG supported

      # Remove collection
      # DELETE https://api.raindrop.io/rest/v1/collection/{id}
      # Remove an existing collection and all its descendants.
      # Raindrops will be moved to "Trash" collection

      # Remove multiple collections
      # DELETE https://api.raindrop.io/rest/v1/collections
      # Remove multiple collections at once.
      # Nested collections are ignored (include ID's in ids array to remove them)

      # Reorder all collections
      # PUT https://api.raindrop.io/rest/v1/collections
      # Updates order of all collections

      # Expand/collapse all collections
      # PUT https://api.raindrop.io/rest/v1/collections

      # Merge collections
      # PUT https://api.raindrop.io/rest/v1/collections/merge

      # Merge multiple collections
      # Remove all empty collections
      # PUT https://api.raindrop.io/rest/v1/collections/clean

      # Empty Trash
      # DELETE https://api.raindrop.io/rest/v1/collection/-99
    end # end of class methods
  end
end
