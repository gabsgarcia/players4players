class RatingPolicy < ApplicationPolicy
  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
