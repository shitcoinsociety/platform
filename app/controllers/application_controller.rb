class ApplicationController < ActionController::Base
  use_inertia_instance_props

  rescue_from ActiveRecord::RecordInvalid do |exception|
    raise exception unless request.inertia?

    redirect_back inertia: {
      errors: exception.record.errors
    }
  end

  rescue_from ActionController::BadRequest do |exception|
    flash[:error] = exception.message
    redirect_back
  end

  inertia_share do
    {
      user_sgid: current_user.try(:signed_id, expires_in: nil),
      flash: flash.to_h
    }
  end

  def inertia_referer
    request.headers["X-Inertia-Frame-Src"] || request.referer
  end

  def redirect_back(fallback_location: namespace_root_path, **args)
    if request.inertia?
      redirect_to inertia_referer || fallback_location, **args
    else
      super
    end
  end

  def current_user
    Current.user ||= (request_is_post? ? User.lock : User).find_by(id: session[:user_id]) if session[:user_id]
  end

  def request_is_post?
    request.post? || request.patch? || request.put? || request.delete?
  end

  def require_user
    unless session[:user_id]
      flash[:error] = "You must be logged in to access this page."
      flash[:modal] = "/session/new"
      redirect_to "/"
    end
  end

  def namespace_root_path
    namespace = self.class.module_parent_name&.underscore
    if namespace.present? && respond_to?("#{namespace}_root_path")
      send("#{namespace}_root_path")
    else
      "/"
    end
  end

  def show_in_modal
    if request.headers["X-Inertia-Frame"] == "_top" || !request.inertia?
      flash[:modal] = request.fullpath
      redirect_to namespace_root_path
    end
  end
end
