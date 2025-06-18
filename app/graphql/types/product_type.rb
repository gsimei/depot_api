# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :description, String
    field :price, Float
    field :stock_quantity, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # Computed fields
    field :in_stock, Boolean, null: false, description: "Whether the product is in stock"
    def in_stock
      object.stock_quantity > 0
    end

    field :price_formatted, String, null: false, description: "Price formatted as currency"
    def price_formatted
      "$%.2f" % object.price
    end

    field :low_stock, Boolean, null: false, description: "Whether the product has low stock (less than 10)"
    def low_stock
      object.stock_quantity < 10
    end
  end
end
