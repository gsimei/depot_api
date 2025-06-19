# frozen_string_literal: true

module Resolvers
  module Product
    class PaginatedListResolver < BaseResolver
      type Types::ProductType.connection_type, null: false
      description "Get all products with pagination"

      argument :first, Integer, required: false, description: "Number of items to return"
      argument :after, String, required: false, description: "Cursor to start from"

      def resolve(first: nil, after: nil)
        ::Product.all
      end
    end
  end
end
