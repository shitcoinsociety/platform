class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end
