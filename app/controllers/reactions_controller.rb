class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reactionable

  def create
    if @reactionable.reactions.where(user: current_user).exists?
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, alert: "You have already reacted to this." }
        format.js { render json: { error: "You have already reacted to this." }, status: :unprocessable_entity }
      end
    else
      @reaction = @reactionable.reactions.build(user: current_user)
      if @reaction.save
        @reactionable.increment!(:like_count)
        set_user_reaction
        respond_to do |format|
          format.html
          format.js { render :update_reaction }
        end
      else
        respond_to do |format|
          format.html
          format.js { render json: { error: "Unable to add reaction." }, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @reaction = @reactionable.reactions.find_by(user: current_user)
    if @reaction && @reaction.destroy
      @reactionable.decrement!(:like_count)
      respond_to do |format|
        format.html
        format.js { render :update_reaction }
      end
    else
      respond_to do |format|
        format.html
        format.js { render json: { error: "Unable to remove reaction." }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_reactionable
    @reactionable = find_reactionable
  end

  def set_user_reaction
    @user_reaction = @reactionable.reactions.find_by(user: current_user)
  end

  def find_reactionable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
