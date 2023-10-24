class UserMailer < ApplicationMailer
  def welcome_mail(user)
    @user=user
    @greeting = "Hi"

    mail(from:"BloggerApp@gmail.com",
         to:@user.email,
         subject: "Sign_up welcome mail"
)
end
end
