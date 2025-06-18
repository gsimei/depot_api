module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [ :show, :update, :destroy ]

      # GET /api/v1/products
      def index
        @products = Product.all
        render json: @products
      end

      # GET /api/v1/products/1
      def show
        render json: @product
      end

      # POST /api/v1/products
      def create
        @product = Product.new(product_params)

        if @product.save
          render json: @product, status: :created
        else
          render json: { errors: @product.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/products/1
      def update
        if @product.update(product_params)
          render json: @product
        else
          render json: { errors: @product.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/products/1
      def destroy
        @product.destroy
        head :no_content
      end

      # GET /api/v1/products/search?q=termo
      def search
        query = params[:q]
        if query.present?
          @products = Product.where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
        else
          @products = Product.all
        end
        render json: @products
      end

      # GET /api/v1/products/in_stock
      def in_stock
        @products = Product.where("stock_quantity > 0")
        render json: @products
      end

      private

      def set_product
        @product = Product.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Product not found" }, status: :not_found
      end

      def product_params
        params.require(:product).permit(:name, :description, :price, :stock_quantity)
      end
    end
  end
end
