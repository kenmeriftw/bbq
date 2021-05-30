class EventPolicy < ApplicationPolicy
  def edit
    is_owner?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  def show?
    return true if record.pincode.blank?
    return true if is_owner?
    return true if record.pincode_valid?(cookies["events_#{record.id}_pincode"])
  end

  private

  def is_owner?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
