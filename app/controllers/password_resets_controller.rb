class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      user.create_reset_token
      user.save
      UserMailer.forgot_password_email(user).deliver_now
      flash[:notice] = 'Password reset instructions sent to your email.'
    else
      flash[:alert] = 'Email address not found.'
    end
    redirect_to root_path
  end

  def edit
    @user = User.find_by(reset_token: params[:reset_token])
  end

  def update
    # @user = User.find_by(reset_token: params[:id])
    @user = User.find_by(reset_token: params[:user][:reset_token])
    if @user.update(password: params[:user][:password])
      flash[:notice] = "password was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
    # if @user && @user.update(password: params[:user][:password])
    #     flash[:notice] = "Password was updated successfully"
    #     redirect_to @user
    #   else
    #     render 'edit'
    #   end
  end
end
