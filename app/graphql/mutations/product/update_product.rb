# frozen_string_literal: true

module Mutations
  module Product
    class UpdateProduct < BaseMutation
      description "Updates an existing product"

      field :product, Types::ProductType, null: true
      field :errors, [ String ], null: false

      argument :id, ID, required: true, description: "Product ID"
      argument :name, String, required: false, description: "Product name"
      argument :description, String, required: false, description: "Product description"
      argument :price, Float, required: false, description: "Product price (must be positive)"
      argument :stock_quantity, Integer, required: false, description: "Stock quantity (must be non-negative)"

      def resolve(id:, **attributes)
        # Validações customizadas
        if attributes[:price] && attributes[:price] <= 0
          raise GraphQL::ExecutionError, "Price must be positive"
        end
        if attributes[:stock_quantity] && attributes[:stock_quantity] < 0
          raise GraphQL::ExecutionError, "Stock quantity must be non-negative"
        end
        if attributes[:name] && attributes[:name].blank?
          raise GraphQL::ExecutionError, "Name cannot be blank"
        end
        product = ::Product.find(id)

        if product.update(attributes.compact)
          {
            product: product,
            errors: []
          }
        else
          {
            product: nil,
            errors: product.errors.full_messages
          }
        end
      rescue ActiveRecord::RecordNotFound
        {
          product: nil,
          errors: [ "Product not found" ]
        }
      end
    end
  end
end
