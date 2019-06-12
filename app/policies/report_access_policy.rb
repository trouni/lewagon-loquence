class ReportAccessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.report.owner == user || user.admin
  end
end
