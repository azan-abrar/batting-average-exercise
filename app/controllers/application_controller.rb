class ApplicationController < ActionController::Base
  # path for the users according to the roles.
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      root_path
    end
  end
end
