class StatusController < ApplicationController
  def index
    @user = User.find_by(user_token: params[:token])
    @user.update({status: true})
    @user.save!
    redirect_to '/dashboard'
  end

  private
  def user_params
    params.require(:user).permit(:username, :password_digest, :user_token, :email, :status).merge(status: true)
  end
end
