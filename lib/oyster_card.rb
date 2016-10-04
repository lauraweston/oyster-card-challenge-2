class OysterCard
  attr_reader :balance, :in_journey, :current_journey, :journey_log

  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
      @balance = 0
      @in_journey = false
      @current_journey = {entry_station: nil, exit_station: nil}
      @journey_log = []
  end

  def top_up(amount)
    raise max_limit if limit_reached?(@balance + amount)
    @balance += amount
  end



  def in_journey?
    !!@current_journey[:entry_station]
  end

  def touch_in(station)
    raise "You don't have enough money" if insufficient_funds?
    add_entry_station(station)
  end

  def touch_out(station, fare = MINIMUM_BALANCE)
    deduct(fare)
    @current_journey[:exit_station] = station.name
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

  def add_entry_station(station)
    @current_journey[:entry_station] = station.name
  end

  def delete_entry_station
    @current_journey[:entry_station] = nil
  end

  def update_log(journey_hash)
    @journey_log.push(journey_hash)
  end

  def clear_current_journey
    @current_journey = {entry_station: nil, exit_station: nil}
  end
end
