
class Journey
attr_reader :current_journey
attr_accessor :exit_station, :entry_station
MINIMUM_FARE = 1
PENALTY_FARE = 6

# allow touch_in and touch_out to update enry_station and exit_station

  def in_journey?
    !!@entry_station
  end

  def fare
    penalty? ? PENALTY_FARE : MINIMUM_FARE
  end

  def penalty?
    entry_station.nil? || exit_station.nil?
  end
end
