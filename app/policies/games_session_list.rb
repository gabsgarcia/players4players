class GamesSessionListPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def new?
    true
  end

  def available?
    true
  end

  def create?
    true
  end

  def destroy?
    true
  end

  class Scope
    # # def initialize(user, scope)
    #   # @user = user
    #   @scope = scope
    # end

    def resolve
      scope.all
    end

    private

    # attr_reader :user, :scope
  end
end
