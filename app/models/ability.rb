class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, Order, user_id: user.id
      can %i[read create update], OrderItem, user_id: user.id
      can :read, Book
      can %i[read create update], CreditCard, user_id: user.id
      can %i[read create update], BillingAddress, user_id: user.id
      can %i[read create update], ShippingAddress, user_id: user.id
      can :manage, User, id: user.id
    end
  end
end
