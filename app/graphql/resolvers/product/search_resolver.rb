# frozen_string_literal: true

module Resolvers
  module Product
    class SearchResolver < BaseResolver
      type [Types::ProductType], null: false
      description "Search products by name or description"

      argument :query, String, required: true, description: "Search term"

      def resolve(query:)
        ::Product.where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
      end
    end
  end
end
