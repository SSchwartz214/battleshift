class ApiController < ActionController::API
  def set_user
    api_key = request.headers["HTTP_X_API_KEY"]
    user = User.find_by(user_token: api_key)
    user
  end

  def set_message(ship_length)
    if ship_length == 3
      "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    elsif ship_length == 2
      "Successfully placed ship with a size of 2. You have 0 ship(s) to place."
    else
      "YOU IDOT"
    end
  end
end
