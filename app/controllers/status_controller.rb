class StatusController < ApplicationController
  def index
    @user = User.find_by(user_token: params[:token])
    @user.status = true
    binding.pry
    @user.save!
    redirect_to '/dashboard'
  end
end
