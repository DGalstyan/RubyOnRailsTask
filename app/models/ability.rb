class Ability
  include CanCan::Ability

  def initialize(user)
    # clear_aliased_actions use this to clear needless aliases like create => new
    @user ||= user

    moderator_access if @user.present?
  end

private

  def moderator_access
    can [:index, :new, :create], Forecast
    can [:show, :destroy], Forecast do |p|
      p.users.where(id: @user.id).any?
    end
  end
end
