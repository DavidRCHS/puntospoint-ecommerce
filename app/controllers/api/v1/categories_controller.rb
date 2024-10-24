class Api::V1::CategoriesController < ApplicationController
  # GET /api/v1/categories
  def index
    categories = Category.all
    render json: categories
  end
end