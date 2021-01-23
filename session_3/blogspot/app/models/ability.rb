# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # All users
    can :index, Article
    
    # Can read public articles
    can :show, Article, public: true

    # Additional permissions for logged in users
    if user.present?
      # Can read private articles
      can :show, Article, public: false

      # Can create articles
      can :new, Article
      can :create, Article

      # Can edit their own articles
      can :edit, Article, user_id: user.id
      can :update, Article, user_id: user.id

      # Can destroy their own articles
      can :destroy, Article, user_id: user.id
    end
  end
end
