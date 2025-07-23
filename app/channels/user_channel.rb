class UserChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_signed(params[:sgid])
    reject_subscription unless user

    state("user").set(user.as_json(User::PRIVATE_JSON_OPTIONS))
    stream_for user
  end

  def unsubscribed
  end
end
