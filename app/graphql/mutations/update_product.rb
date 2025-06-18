module Mutations
  class UpdateProduct < BaseMutation
    description "Updates an existing product"

    field :product, Types::ProductType, null: true
    field :errors, [ String ], null: false

    argument :id, ID, required: true
    argument :name, String, required: false
    argument :description, String, required: false
    argument :price, Float, required: false
    argument :stock_quantity, Integer, required: false

    def resolve(id:, **attributes)
      product = Product.find(id)

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
