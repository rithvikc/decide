class Users::InvitationsController < Devise::InvitationsController

  def edit
    super
  end

  def update
    super
  end

  private

  def accept_resource
  end
end
