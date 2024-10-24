require 'rails_helper'

RSpec.describe 'API', type: :request do
  let(:admin) { Admin.create!(email: 'admin@example.com', password_digest: Digest::SHA256.hexdigest('password')) }
  let(:secret_key) { 'my_secret_key' }
  let(:token) { JWT.encode({ admin_id: admin.id }, secret_key) }

  describe 'GET /api/v1/purchases' do
    it 'returns purchases based on provided filters' do
      get '/api/v1/purchases', { from: '2023-05-01', to: '2023-06-01' }, { 'Authorization' => "Bearer #{token}" }

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to be_an(Array)
    end
  end

  describe 'GET /api/v1/purchases/count_by_granularity' do
    it 'returns the count of purchases based on granularity' do
      get '/api/v1/purchases/count_by_granularity', { granularity: 'day' }, { 'Authorization' => "Bearer #{token}" }

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to be_a(Hash)
    end
  end
end
