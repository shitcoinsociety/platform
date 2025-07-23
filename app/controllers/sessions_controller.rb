class SessionsController < ApplicationController
  before_action :show_in_modal, except: [ :destroy ]

  def new
  end

  def create
    # we take the email from the query parameters so our proxy can do rate-limiting
    email = request.query_parameters[:email]
    user = User.verified.find_by(email: email)
    unless user&.authenticate(params[:password])
      raise ActionController::BadRequest, "Invalid email or password"
    end
    flash.now[:notice] = "You have been logged in"
    session[:user_id] = user.id
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have been logged out"
  end
end
