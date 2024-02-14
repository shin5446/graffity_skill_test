class UsersController < ApplicationController
  before_action :authenticate_with_token, only: [:show]

  # signup
  def create
    user = User.new(user_params)

    if user.save!
      render json: { user_id: user.id }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: { name: current_user.name, email: current_user.email }, status: :ok
  end

  private

  def authenticate_with_token
    auth_header = request.headers['Authorization']
    unless auth_header&.start_with?('Bearer ')
      render json: { error: 'No token or invalid token format' }, status: :unauthorized
      return
    end

    token = auth_header.split(' ').last

    key = User.redis.keys("user:*:session_token").find { |k| User.redis.get(k) == token }
    unless key
      render json: { error: 'Unauthorized access' }, status: :unauthorized
      return
    end

    user_id = key.split(':')[1]
    @current_user = User.find_by(id: user_id)
    unless @current_user
      render json: { error: 'Invalid or expired token' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
