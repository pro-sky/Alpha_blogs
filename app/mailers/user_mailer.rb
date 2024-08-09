class UserMailer < ApplicationMailer
    def forgot_password_email(user)
        @user = user
        @url = edit_password_reset_url(@user.reset_token)
        mail(to: @user.email, subject: 'Forgot Password Request')
      end

    def contact_email(name, email, mobile, message)
      @name = name
      @mobile = mobile
      @email = email
      @message = message

      mail(to: 'sujeetkumaryadavsky0@gmail.com', subject: 'New Contact Form Submission')
    end
end
