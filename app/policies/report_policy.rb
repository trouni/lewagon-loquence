class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    # TODO: Can company update the report?
    record.owner == user
  end

  def create?
    return true
  end

  def show?
    # TODO: add company when Alex completes model for the company
    true
  end

  def destroy?
    record.user == user
  end
end
