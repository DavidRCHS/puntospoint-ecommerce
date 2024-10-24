class Api::V1::AuthController < ApplicationController
  skip_before_filter :authenticate_admin!

  # POST /api/v1/auth/login
  def login
    if request.content_type == 'application/json'
      body_params = JSON.parse(request.body.read)
      params.merge!(body_params)
    end

    admin = Admin.where(email: params[:email]).first

    if admin && admin.password_digest == Digest::SHA256.hexdigest(params[:password])
      token = jwt_encode(admin_id: admin.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def jwt_encode(payload)
    # Set expiration time to 10 minutes from now
    expiration_time = 10.minutes.from_now.to_i
    payload[:exp] = expiration_time

    secret_key = 'my_secret_key'
    JWT.encode(payload, secret_key)
  end
end
