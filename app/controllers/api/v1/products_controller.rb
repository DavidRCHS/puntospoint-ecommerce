class Api::V1::ProductsController < ApplicationController
  before_filter :authenticate_admin!

  # GET /api/v1/products
  def index
    products = Product.all
    render json: products
  end

  # GET /api/v1/products/:id
  def show
    product = Product.where(id: params[:id])
    if product
      render json: product
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  # PUT /api/v1/products/:id
  def update
    # Get the product
    product = Product.where(id: params['id']).first

    if product
      # Get the admin from the token
      admin = current_admin_from_token
      if admin
        # Set the controller info for PaperTrail
        PaperTrail.whodunnit = admin.id.to_s

        # Update the product
        if params['description'].present?
          product.update_attribute(:description, params['description'])
          render json: product
        else
          render json: { 'error' => 'No description provided' }, status: :unprocessable_entity
        end
      else
        render json: { 'error' => 'Invalid admin token' }, status: :unauthorized
      end
    else
      render json: { 'error' => 'Product not found' }, status: :not_found
    end
  end

  # GET /api/v1/products/most_purchased
  def most_purchased
    results = Category.joins(products: :purchases)
                    .select('categories.name AS category_name, products.name AS product_name, COUNT(purchases.id) AS total_purchases')
                    .group('categories.name, products.name')
                    .order('categories.name, total_purchases DESC')
    render json: results
  end

  # GET /api/v1/products/top_revenue
  def top_revenue
    results = Category.joins(products: :purchases)
                      .select('categories.name AS category_name, products.name AS product_name, SUM(purchases.total_price) AS total_revenue')
                      .group('categories.name, products.name')
                      .order('categories.name, total_revenue DESC')

    # Group by category and map the top 3 products by revenue
    top_revenue_by_category = results.group_by(&:category_name).map do |category, products|
      {
        category_name: category,
        top_products: products.first(3).map do |product|
          {
            product_name: product.product_name,
            total_revenue: product.total_revenue
          }
        end
      }
    end

    render json: top_revenue_by_category
  end

  private

  def product_params
    params.require('product').permit('name', 'description', 'price')
  end
end
