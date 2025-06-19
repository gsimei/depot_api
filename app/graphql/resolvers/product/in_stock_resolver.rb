# frozen_string_literal: true

module Resolvers
  module Product
    class InStockResolver < BaseResolver
      type [Types::ProductType], null: false
      description "Get products that are in stock"

      def resolve
        ::Product.where("stock_quantity > 0")
      end
    end
  end
end
