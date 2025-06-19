# frozen_string_literal: true

module Mutations
  module Product
    class CreateProduct < BaseMutation
      description "Creates a new product"

      field :product, Types::ProductType, null: true
      field :errors, [ String ], null: false

      argument :name, String, required: true, description: "Product name"
      argument :description, String, required: false, description: "Product description"
      argument :price, Float, required: true, description: "Product price (must be positive)"
      argument :stock_quantity, Integer, required: true, description: "Stock quantity (must be non-negative)"

      def resolve(name:, price:, stock_quantity:, description: nil)
        # Validações customizadas
        raise GraphQL::ExecutionError, "Price must be positive" if price <= 0
        raise GraphQL::ExecutionError, "Stock quantity must be non-negative" if stock_quantity < 0
        raise GraphQL::ExecutionError, "Name cannot be blank" if name.blank?
        product = Product.new(
          name: name,
          description: description,
          price: price,
          stock_quantity: stock_quantity
        )

        if product.save
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
      end
    end
  end
end
