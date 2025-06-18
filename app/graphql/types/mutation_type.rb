# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Product mutations
    field :create_product, mutation: Mutations::CreateProduct
    field :update_product, mutation: Mutations::UpdateProduct
    field :delete_product, mutation: Mutations::DeleteProduct
  end
end
