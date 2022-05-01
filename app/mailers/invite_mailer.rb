class InviteMailer < ApplicationMailer
  default from: "tatskpad@outlook.com"
  def invite_email(email:)
    @organization_name = "TaTsk Pad"
    @invite_link = "http://localhost:3000"
    mail(
      to: email, 
      subject: "Invitation to join Tatskpad",
      template_path: "invite_mailer",
      template_name: "invite"
    )
  end
end
