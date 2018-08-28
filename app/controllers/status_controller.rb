class StatusController < ApplicationController
  def index
    @user = User.find_by(email: params[:email])
    @user.status = true
    @user.save
    redirect_to '/dashboard'
  end
end
