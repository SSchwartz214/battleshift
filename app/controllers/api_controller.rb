class ApiController < ActionController::API
  def set_user
    api_key = request.headers["HTTP_X_API_KEY"]
    @user = User.find_by(user_token: )
  end
end
