class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    @user.id == @record.id || @user.admin?
  end

end
