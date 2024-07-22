# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
      can [:update, :destroy], :all
    else
      can :read, :all
      can :create, Article if user.persisted?
      can  [:update, :destroy], Article, user_id: user.id
      can  [:update, :destroy], User, id: user.id
      
    end
  end
end
