class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      StatusChangerMailer.change_status(@user).deliver_now
      redirect_to '/dashboard'
    else
      flash[:message] = 'Invalid input, please ensure all fields are filled out correctly.'
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
