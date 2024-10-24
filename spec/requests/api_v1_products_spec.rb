require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let(:admin) do
    Admin.create!(email: 'alice@example.com', password_digest: Digest::SHA256.hexdigest('password'))
  end
  let(:secret_key) { 'my_secret_key' }
  let(:token) { JWT.encode({ admin_id: admin.id }, secret_key) }
  let(:product) do
    Product.create!(name: 'SmartLight', description: 'Test product', price: 399.99, admin: admin)
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
