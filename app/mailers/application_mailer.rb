class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@nonexistant.com'
  layout 'mailer'
end
