# frozen_string_literal: true

module Resolvers
  module Product
    class ListResolver < BaseResolver
      type [Types::ProductType], null: false
      description "Get all products"

      def resolve
        ::Product.all
      end
    end
  end
end
