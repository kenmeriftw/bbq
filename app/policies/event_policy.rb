class EventPolicy < ApplicationPolicy
  def edit?

  end

  def update?
    @user == @record.user
  end

  def destroy?

  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
