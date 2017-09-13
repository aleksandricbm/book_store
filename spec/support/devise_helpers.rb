module DeviseRequestSpecHelpers

  include Warden::Test::Helpers

  def sign_in(resource_or_scope, resource = nil)
    resource ||= resource_or_scope
    # scope = Devise::Mapping.find_scope!(resource_or_scope)
    # login_as(resource, scope: scope)
    # user = FactoryGirl.create(:user)
    login_as(resource_or_scope, scope: :user, run_callbacks: false)
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
  end

end
