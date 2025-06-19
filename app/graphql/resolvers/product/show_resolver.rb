# frozen_string_literal: true

module Resolvers
  module Product
    class ShowResolver < BaseResolver
      type Types::ProductType, null: true
      description "Get a specific product by ID"

      argument :id, ID, required: true, description: "Product ID"

      def resolve(id:)
        ::Product.find_by(id: id)
      end
    end
  end
end
