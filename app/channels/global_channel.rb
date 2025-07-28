class GlobalChannel < ApplicationCable::Channel
  def subscribed
    state("prices.sat-eur").set(Price.as_timeseries(:sat, :eur))
    stream_from "global:prices"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
