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
    flash[:notice] = "You have been logged in"
    session[:user_id] = user.id
    redirect_back
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", notice: "You have been logged out"
  end
end
