class VerifyAccountMailer < ApplicationMailer
  def send_verify_email(account)
    @account = account
    mail(to: account.email, subject: "Verify your account")
  end
end
