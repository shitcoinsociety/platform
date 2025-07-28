class Price < ApplicationRecord
  before_create :set_delete_at
  after_create_commit :broadcast

  def self.as_timeseries(base, quote)
    # Fetch all prices for the given pair, ordered by created_at
    prices = Price.where(base: base, quote: quote).order(:created_at).pluck(:created_at, :value)

    # Map the prices to an array of arrays with timestamps and values
    prices.map do |created_at, value|
      [ created_at.to_i, value.to_f ]
    end
  end

  private
  def set_delete_at
    seconds = Time.now.utc.strftime("%S").to_i
    minutes = Time.now.utc.strftime("%M").to_i
    hours = Time.now.utc.strftime("%H").to_i
    # days = Time.now.utc.strftime("%d").to_i
    unless hours == 0
      self.delete_at = 1.month.from_now
    end
    unless hours % 4 == 0
      self.delete_at = 1.week.from_now
    end
    unless minutes == 0
      self.delete_at = 1.day.from_now
    end
    unless minutes % 10 == 0
      self.delete_at = 1.hour.from_now
    end
    unless seconds < 3
      self.delete_at = 5.minutes.from_now
    end
  end

  def broadcast
    GlobalChannel["prices"].state("prices", pair).push([ created_at.to_i, value.to_f ])
  end

  def pair
    "#{base}-#{quote}"
  end
end
