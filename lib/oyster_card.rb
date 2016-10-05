#require_relative "station"
require_relative "journey"

class OysterCard
  attr_reader :balance, :in_journey, :current_journey, :journey_log

  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1
  

  def initialize
      @balance = 0
      @in_journey = false
      @current_journey = nil
      @journey_log = []
  end

  def top_up(amount)
    raise max_limit if limit_reached?(@balance + amount)
    @balance += amount
  end

  def in_journey?
    !@current_journey.nil?
  end

  def touch_in(station)
    raise "You don't have enough money" if insufficient_funds?
    #add_entry_station(station)
    new_journey(station)
  end

  def touch_out(station, fare = MINIMUM_BALANCE)
    current_journey.exit_station = station.name
    deduct(fare)
    update_log(@current_journey)
    clear_current_journey
  end

  private

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
    @balance < MINIMUM_BALANCE
  end

  def new_journey(station)
    @current_journey = Journey.new(station)
  end

  def delete_entry_station
    @current_journey[:entry_station] = nil
  end

  def update_log(journey)
    @journey_log << journey
  end

  def clear_current_journey
    @current_journey = nil
  end
end
