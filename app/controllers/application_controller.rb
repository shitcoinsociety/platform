class ApplicationController < ActionController::Base
  # allow_browser versions: :modern
  use_inertia_instance_props

  before_action :save_ref_code

  rescue_from ActiveRecord::RecordInvalid do |exception|
    raise exception unless request.inertia?

    redirect_back inertia: {
      errors: exception.record.errors
    }
  end

  inertia_share do
    {
      current_user: current_user.as_json(User::JSON_OPTIONS),
      signed_user_id: current_user.try(:signed_id, expires_in: 1.hour),
      flash: flash.to_h
    }
  end

  # Overwrite redirect_back so we don't have to specify fallback_location every time
  def redirect_back(fallback_location: namespace_root_path, **args)
    super
  end

  def namespace_root_path
    namespace = self.class.module_parent_name&.underscore
    if namespace.present? && respond_to?("#{namespace}_root_path")
      send("#{namespace}_root_path")
    else
      "/"
    end
  end

  def current_user
    Current.user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def save_ref_code
    if params[:ref].present?
      session[:ref_code] = params[:ref]
    end
  end

  def require_user
    unless current_user
      flash[:error] = "You must be logged in to access that page."
      redirect_to new_user_path
    end
  end
end
