class GameSessionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    user_is_owner_or_admin?
    # - record: the offer passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    user_is_owner_or_admin?
  end

  def show?
    return true
  end

  def search?
    return true
  end

  private

  def user_is_owner_or_admin?
    @user == record.user || user.admin
  end
end
