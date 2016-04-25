class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.role == 'lecturer'
      can :manage, :all
      cannot [:create, :update, :destroy], User
    elsif user && user.role == 'student'
      can :read, :all
    elsif user && user.role == 'admin'
      can :manage, :all
    else
      cannot :manage, :all
    end
  end

end
