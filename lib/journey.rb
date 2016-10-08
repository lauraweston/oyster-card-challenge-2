class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :exit_station, :entry_station

  def started?
    !!entry_station
  end

  def fare
    penalty? ? PENALTY_FARE : MINIMUM_FARE
  end

  private

  def penalty?
    entry_station.nil? || exit_station.nil?
  end
end
