class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Api::User.new # guest user (not logged in)

    admin_rights(user) if user.is_a?(AdminUser)

    api_rights(user) if user.is_a?(Api::User)
  end

  def admin_rights(admin)
    can :access, :admin_dashboard

    can [:index, :show, :update, :delete, :create], AdminUser
    can [:index, :show, :update, :delete, :create], Api::User
    can [:index, :show, :update, :delete, :create], Restaurant
    can [:index, :show, :update, :delete, :create], Lunch
  end

  def api_rights(api_user)
    can [:index, :show], Restaurant
    can [:index, :show], Lunch
    can [:create, :update], Restaurant, :api_user_id => api_user.id
    can [:create, :update, :delete], Lunch, :restaurant => { :api_user_id => api_user.id }
  end

end
