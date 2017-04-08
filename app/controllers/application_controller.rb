class ApplicationController < ActionController::API
  before_action :authenticate_user

  private
  def authenticate_user
    user_token = request.headers['X-USER-TOKEN']
    if user_token
      user = User.find_by(token: user_token)
      # unauthorize if the user is not found
      if user.nil?
        return unauthorize
      end
    else
      # unauthorize if no token is provided
      return unauthorize
    end
  end

  def unauthorize
    head status: :unauthorized
    return false
  end

end
