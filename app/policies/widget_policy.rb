class WidgetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.report.owner == user
  end

  def update?
    record.report.owner == user
  end

  def destroy?
    record.report.owner == user
  end
end
