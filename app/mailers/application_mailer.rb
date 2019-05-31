class ApplicationMailer < ActionMailer::Base
  default from: Settings.default_from_email
  layout "mailer"

  def account_activation
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
