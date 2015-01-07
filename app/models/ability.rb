class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can :manage, :all
    elsif user.normal_user?
      can [:create], Job
      can [:read, :update, :destroy], Job, :org_id => user.org_ids
      can [:create], Org
      can [:read, :update, :destroy], Org, :id => user.org_ids
    else
    end
    
    can :read, [Job, Org, Type, Category]
  end
end
