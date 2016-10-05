
class Journey
attr_reader :current_journey, :entry_station
attr_accessor :exit_station
MINIMUM_FARE = 1
PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station.name
  end
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
