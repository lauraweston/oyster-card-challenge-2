#require_relative "station"
require_relative "journey"

class OysterCard
  attr_reader :balance, :in_journey, :current_journey, :journey_log

  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1


  def initialize
      @balance = 0
      @in_journey = false
      @current_journey = Journey.new
      @journey_log = []
  end

  def top_up(amount)
    raise max_limit if limit_reached?(balance + amount)
    @balance += amount
  end

  def touch_in(station)
    finish_journey if double_entry?
    raise "You don't have enough money" if insufficient_funds?
    current_journey.entry_station = station
  end

  def touch_out(station)
    current_journey.exit_station = station
    finish_journey
  end

  private
  def finish_journey
    deduct(current_journey.fare)
    update_log
    reset_current_journey
  end

  def double_entry?
    current_journey.entry_station != nil
  end

  def deduct(amount)
    @balance -= amount
  end

  def max_limit
    "The maximum amount allowed on the card is £#{MAX_LIMIT}"
  end

  def limit_reached?(amount)
    (amount) > MAX_LIMIT
  end

  def insufficient_funds?
    balance < MINIMUM_BALANCE
  end

  def update_log
    @journey_log << current_journey
  end

  def reset_current_journey
    @current_journey = Journey.new
  end
end
