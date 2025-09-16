class UsersController < ApplicationController
  before_action :require_user, only: [ :show ]

  def new
  end

  def show
    @balance = current_user.balances.find_by(symbol: "sat").current
  end
end
