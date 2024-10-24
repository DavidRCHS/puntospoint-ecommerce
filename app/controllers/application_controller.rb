class ApplicationController < ActionController::Base
  before_filter :authenticate_admin!

  private

  # This method is used to authenticate the admin user.
  def authenticate_admin!
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    if token
      decoded = jwt_decode(token)
      @current_admin = Admin.where(id: decoded[:admin_id]).first if decoded
      puts "Decoded token: #{decoded.inspect}"
    end

    unless @current_admin
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def jwt_decode(token)
    secret_key = 'my_secret_key'
    JWT.decode(token, secret_key, true, algorithm: 'HS256')[0].symbolize_keys
  rescue JWT::DecodeError => e
    puts "JWT Decode Error: #{e.message}"
    nil
  end
end
