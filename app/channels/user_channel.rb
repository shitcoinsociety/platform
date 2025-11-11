class UserChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_signed(params[:signed_user_id])
    reject unless user

    state("transactions").set(user.transactions.limit(5).as_json)
    stream_for user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
