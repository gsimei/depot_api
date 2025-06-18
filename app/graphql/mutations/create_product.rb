module Mutations
  class CreateProduct < BaseMutation
    description "Creates a new product"

    field :product, Types::ProductType, null: true
    field :errors, [ String ], null: false

    argument :name, String, required: true
    argument :description, String, required: false
    argument :price, Float, required: true
    argument :stock_quantity, Integer, required: true

    def resolve(name:, price:, stock_quantity:, description: nil)
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
