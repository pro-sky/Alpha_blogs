class DirectMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def new
    @receiver = User.find(params[:receiver_id])
    @direct_message = DirectMessage.new
  end

  def create
    @direct_message = DirectMessage.new(direct_message_params)
    @direct_message.sender = current_user
    @direct_message.receiver = User.find(params[:direct_message][:receiver_id])

    if @direct_message.save
      Rails.logger.info("Broadcasting message to user: #{@direct_message.receiver.id} - Message: #{render_message(@direct_message)}")
      DirectMessageChannel.broadcast_to(@direct_message.receiver.id,message: render_message(@direct_message))
      redirect_to user_direct_messages_path(@direct_message.receiver)
    else
      render :new
    end
  end

  def index
    @receiver = User.find(params[:user_id])
    @direct_messages = DirectMessage.between(current_user.id, @receiver.id).order(:created_at)
    @direct_message = DirectMessage.new
  end

  def chats
    @users = User.joins("INNER JOIN direct_messages ON direct_messages.sender_id = users.id OR direct_messages.receiver_id = users.id")
                  .where("direct_messages.sender_id = ? OR direct_messages.receiver_id = ?", current_user.id, current_user.id)
                  .distinct
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:message, :receiver_id)
  end

  def render_message(direct_message)
    ApplicationController.renderer.render(partial: 'direct_messages/direct_message', locals: { direct_message: direct_message })
  end
end
