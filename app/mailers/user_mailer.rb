class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.msg1")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailer.msg3")
  end
end
