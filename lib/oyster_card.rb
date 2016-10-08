class OysterCard
  MAX_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance

  def initialize(journey_log)
      @balance = 0
      @journey_log = journey_log
  end

  def top_up(amount)
    raise max_limit_error if limit_reached?(balance + amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Please top up the card" if insufficient_funds?
    journey_cost = journey_log.start(station)
    deduct(journey_cost)
  end

  def touch_out(station)
    journey_cost = journey_log.finish(station)
    deduct(journey_cost)
  end

  private
  attr_reader :journey_log

  def deduct(amount)
    @balance -= amount
  end

  def max_limit_error
    "The maximum amount allowed on the card is £#{MAX_LIMIT}"
  end

  def limit_reached?(amount)
    amount > MAX_LIMIT
  end

  def insufficient_funds?
    balance < MINIMUM_BALANCE
  end
end
