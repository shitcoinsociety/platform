class UserChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_signed(params[:sgid])
    reject_subscription unless user

    # initialize client state after connection
    state("user").set(user.as_json(User::PRIVATE_JSON_OPTIONS))
    state("transactions").set(user.transactions.limit(3).as_json(Transaction::JSON_OPTIONS))

    stream_for user
  end

  def unsubscribed
  end
end
