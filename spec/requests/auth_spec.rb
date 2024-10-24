require 'spec_helper'

RSpec.describe 'Auth API', type: :request do
  describe 'POST /api/v1/auth/login' do
    let!(:admin) { Admin.create(email: 'alice@example.com', password_digest: Digest::SHA256.hexdigest('password')) }

    it 'returns a JWT token with valid credentials' do
      post '/api/v1/auth/login',
           { email: admin.email, password: 'password' }.to_json,
           { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)).to have_key('token')
    end

    it 'returns an error with invalid credentials' do
      post '/api/v1/auth/login',
           { email: admin.email, password: 'wrong_password' }.to_json,
           { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eq(401)
      expect(JSON.parse(last_response.body)['error']).to eq('Invalid email or password')
    end
  end
end
