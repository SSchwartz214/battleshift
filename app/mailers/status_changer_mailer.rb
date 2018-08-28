class StatusChangerMailer < ApplicationMailer
  def change_status(user)
    @user = user
    mail(to: @user.email, subject: 'Activate your Battleshift account!')
  end
end
