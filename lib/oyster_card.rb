class OysterCard
attr_reader :balance

MAX_LIMIT = 90

  def initialize
      @balance = 0
  end

  def top_up(amount)
    raise max_limit if (@balance + amount) > MAX_LIMIT
    @balance += amount
    @amount = amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def max_limit
    "The maximum amount allowed on the card is £#{MAX_LIMIT}"
  end



end
