class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true

    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can :read, Post, user_id: user.id

      if user.admin?  # additional permissions for administrators
        can :read, post
      end
    end
  end
end
