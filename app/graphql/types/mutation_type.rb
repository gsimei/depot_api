# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Product mutations
    field :create_product, mutation: Mutations::Product::CreateProduct
    field :update_product, mutation: Mutations::Product::UpdateProduct
    field :delete_product, mutation: Mutations::Product::DeleteProduct
  end
end
