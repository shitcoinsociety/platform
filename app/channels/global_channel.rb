class GlobalChannel < ApplicationCable::Channel
  def subscribed
    state("connected").set(true)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
