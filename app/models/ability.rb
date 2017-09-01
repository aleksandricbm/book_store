class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can [:read, :create, :update], Order, user_id: user.id
      can [:read, :create, :update], OrderItem, user_id: user.id
      can [:read], Book
      can [:create], Review
      can [:read, :create, :update], CreditCard, user_id: user.id
      can [:read, :create, :update], BillingAddress, user_id: user.id
      can [:read, :create, :update], ShippingAddress, user_id: user.id
    end
  end
end
