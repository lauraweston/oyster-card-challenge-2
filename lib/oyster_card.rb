class OysterCard
  attr_reader :balance, :in_journey, :entry_station

  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
      @balance = 0
      @in_journey = false
  end

  def top_up(amount)
    raise max_limit if limit_reached?(@balance + amount)
    @balance += amount
  end



  def in_journey?
    in_journey
  end

  def touch_in(station_name)
    raise "You don't have enough money" if insufficient_funds?
    @entry_station = station_name.name
    @in_journey = true
  end

  def touch_out(fare = MINIMUM_BALANCE)
    deduct(fare)
    @in_journey = false
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


end
