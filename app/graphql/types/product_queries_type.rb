module Types
  class ProductQueriesType < Types::BaseObject
    field :products, [Types::ProductType], null: false,
      description: "Get all products"
    def products
      Product.all
    end

    field :product, Types::ProductType, null: true,
      description: "Get a specific product by ID" do
      argument :id, ID, required: true
    end
    def product(id:)
      Product.find_by(id: id)
    end

    field :search_products, [Types::ProductType], null: false,
      description: "Search products by name or description" do
      argument :query, String, required: true
    end
    def search_products(query:)
      Product.where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
    end

    field :products_by_price_range, [Types::ProductType], null: false,
      description: "Get products within a price range" do
      argument :min_price, Float, required: false
      argument :max_price, Float, required: false
    end
    def products_by_price_range(min_price: nil, max_price: nil)
      scope = Product.all
      scope = scope.where("price >= ?", min_price) if min_price
      scope = scope.where("price <= ?", max_price) if max_price
      scope
    end

    field :products_in_stock, [Types::ProductType], null: false,
      description: "Get products that are in stock"
    def products_in_stock
      Product.where("stock_quantity > 0")
    end
  end
end
