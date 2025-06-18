require "test_helper"

class GraphqlProductsTest < ActionDispatch::IntegrationTest
  setup do
    # Limpa todos os produtos antes de executar o teste
    Product.delete_all

    @product1 = Product.create!(name: "MacBook Pro", description: "Apple MacBook Pro", price: 1999.99, stock_quantity: 5)
    @product2 = Product.create!(name: "iPhone 15", description: "Latest iPhone", price: 799.99, stock_quantity: 0)
  end

  test "should return all products" do
    post "/graphql", params: { query: "{ products { id name price stockQuantity inStock } }" }
    json = JSON.parse(@response.body)
    assert_equal 2, json["data"]["products"].size
    assert_equal "MacBook Pro", json["data"]["products"][0]["name"]
  end

  test "should return a product by id" do
    post "/graphql", params: { query: "{ product(id: \"#{@product1.id}\") { name price } }" }
    json = JSON.parse(@response.body)
    assert_equal "MacBook Pro", json["data"]["product"]["name"]
  end

  test "should search products by name" do
    post "/graphql", params: { query: '{ searchProducts(query: "iPhone") { id name } }' }
    json = JSON.parse(@response.body)
    assert_equal "iPhone 15", json["data"]["searchProducts"][0]["name"]
  end

  test "should return products in stock" do
    post "/graphql", params: { query: "{ productsInStock { name inStock } }" }
    json = JSON.parse(@response.body)
    assert json["data"]["productsInStock"].all? { |p| p["inStock"] }
  end

  test "should return products within price range" do
    post "/graphql", params: { query: "{ productsByPriceRange(minPrice: 500, maxPrice: 1000) { name price } }" }
    json = JSON.parse(@response.body)
    assert_equal 1, json["data"]["productsByPriceRange"].size
    assert_equal "iPhone 15", json["data"]["productsByPriceRange"][0]["name"]
  end

  test "should format price as currency" do
    post "/graphql", params: { query: "{ product(id: \"#{@product1.id}\") { priceFormatted } }" }
    json = JSON.parse(@response.body)
    assert_equal "$1999.99", json["data"]["product"]["priceFormatted"]
  end

  teardown do
    # Limpa todos os produtos após a execução do teste
    Product.delete_all
  end
end
