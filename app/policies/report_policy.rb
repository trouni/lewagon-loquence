class ReportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.joins(:owner).where(users: { company_id: user.company_id })
      # scope.where(owner: user).order(:name)
      user.reports
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
    # record.company == user.company
    user.reports.include?(record) || user.admin
  end

  def destroy?
    record.user == user
  end
end
