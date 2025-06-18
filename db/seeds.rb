# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.delete_all

Product.create!([
  {
    name: 'MacBook Pro',
    description: 'Apple MacBook Pro 14-inch with M3 chip',
    price: 1999.99,
    stock_quantity: 5
  },
  {
    name: 'iPhone 15',
    description: 'Latest iPhone with Dynamic Island',
    price: 799.99,
    stock_quantity: 0
  },
  {
    name: 'iPad Air',
    description: 'iPad Air with M2 chip, 11-inch display',
    price: 599.99,
    stock_quantity: 15
  },
  {
    name: 'AirPods Pro',
    description: 'Wireless earbuds with Active Noise Cancellation',
    price: 249.99,
    stock_quantity: 3
  }
])
