require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let(:admin) { Admin.create!(email: 'admin@example.com', password_digest: Digest::SHA256.hexdigest('password')) }
  let(:secret_key) { 'my_secret_key' }
  let(:token) { JWT.encode({ admin_id: admin.id }, secret_key) }

  describe 'GET #index' do
    it 'returns a list of products' do
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(Product.count)
    end
  end

  describe 'POST #create' do
    it 'creates a new product' do
      expect {
        post :create, params: { product: { name: 'New Product', description: 'New description', price: 100, admin_id: @admin.id } }, format: :json
      }.to change(Product, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('New Product')
    end
  end

  describe 'PUT #update' do
    it 'updates an existing product' do
      put :update, params: { id: product.id, product: { name: 'Updated Product' } }, format: :json

      expect(response).to have_http_status(:ok)
      expect(product.reload.name).to eq('Updated Product')
    end
  end


  describe 'GET /api/v1/products/top_revenue' do
    it 'returns the top 3 products by revenue in each category' do
      get '/api/v1/products/top_revenue', {}, { 'Authorization' => "Bearer #{token}" }

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to be_an(Array)
    end
  end

  describe 'GET /api/v1/products/most_purchased' do
    it 'returns the most purchased products by category' do
      get '/api/v1/products/most_purchased', {}, { 'Authorization' => "Bearer #{token}" }

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to be_an(Array)
    end
  end
end
