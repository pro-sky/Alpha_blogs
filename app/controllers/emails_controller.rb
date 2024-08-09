class EmailsController < ApplicationController
  protect_from_forgery with: :null_session, only: [:send_email]

  def send_email
    first_name = params[:firstName]
    last_name = params[:lastName]
    email = params[:email]
    mobile = params[:mobile]
    message = params[:message]
    full_name = "#{first_name} #{last_name}"

    UserMailer.contact_email(full_name, email, mobile, message).deliver_now

    render json: { success: true, message: 'Email sent successfully' }
  rescue StandardError => e
    render json: { success: false, message: 'Failed to send email', error: e.message }
  end

end
