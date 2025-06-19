# frozen_string_literal: true

module Mutations
  module Product
    class DeleteProduct < BaseMutation
      description "Deletes a product"

      field :success, Boolean, null: false
      field :errors, [ String ], null: false

      argument :id, ID, required: true

      def resolve(id:)
        product = ::Product.find(id)

        if product.destroy
          {
            success: true,
            errors: []
          }
        else
          {
            success: false,
            errors: product.errors.full_messages
          }
        end
      rescue ActiveRecord::RecordNotFound
        {
          success: false,
          errors: [ "Product not found" ]
        }
      end
    end
  end
end
