# frozen_string_literal: true

module Resolvers
  module Product
    class PriceRangeResolver < BaseResolver
      type [Types::ProductType], null: false
      description "Get products within a price range"

      argument :min_price, Float, required: false, description: "Minimum price"
      argument :max_price, Float, required: false, description: "Maximum price"

      def resolve(min_price: nil, max_price: nil)
        scope = ::Product.all
        scope = scope.where("price >= ?", min_price) if min_price
        scope = scope.where("price <= ?", max_price) if max_price
        scope
      end
    end
  end
end
