class OysterCard
  attr_reader :balance, :in_journey, :entry_station, :current_journey

  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
      @balance = 0
      @in_journey = false
      @current_journey = {entry_station: nil}
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

  def touch_out(fare = MINIMUM_BALANCE)
    deduct(fare)
    delete_entry_station
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
end
