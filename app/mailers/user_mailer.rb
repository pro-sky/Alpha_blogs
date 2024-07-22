class UserMailer < ApplicationMailer
    def forgot_password_email(user)
        @user = user
        @url = edit_password_reset_url(@user.reset_token)
        mail(to: @user.email, subject: 'Forgot Password Request')
      end
end
