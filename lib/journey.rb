
class Journey
attr_reader :current_journey, :entry_station
attr_accessor :exit_station

  def initialize(station)
    @entry_station = station.name
  end
# allow touch_in and touch_out to update enry_station and exit_station

  def in_journey?
    !!@entry_station
  end
end
