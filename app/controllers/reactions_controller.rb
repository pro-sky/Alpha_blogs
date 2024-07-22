class ReactionsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_reactionable

  def create
    if @reactionable.reactions.where(user: current_user).exists?
      redirect_back fallback_location: root_path, alert: "You have already reacted to this."
    else
      @reaction = @reactionable.reactions.build(user: current_user)
      if @reaction.save
        @reactionable.increment!(:like_count)
        redirect_back fallback_location: root_path, notice: "Reaction added."
      else
        redirect_back fallback_location: root_path, alert: "Unable to add reaction."
      end
    end
  end

  def destroy
    @reaction = @reactionable.reactions.find_by(user: current_user)
    if @reaction && @reaction.destroy
      @reactionable.decrement!(:like_count)
      redirect_back fallback_location: root_path, notice: "Reaction removed."
    else
      redirect_back fallback_location: root_path, alert: "Unable to remove reaction."
    end
  end

  private

  def set_reactionable
    @reactionable = find_reactionable
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
