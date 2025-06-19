# frozen_string_literal: true

module Types
  class ProductQueriesType < Types::BaseObject
    field :products, resolver: Resolvers::Product::ListResolver
    field :products_paginated, resolver: Resolvers::Product::PaginatedListResolver
    field :product, resolver: Resolvers::Product::ShowResolver
    field :search_products, resolver: Resolvers::Product::SearchResolver
    field :products_by_price_range, resolver: Resolvers::Product::PriceRangeResolver
    field :products_in_stock, resolver: Resolvers::Product::InStockResolver
  end
end
