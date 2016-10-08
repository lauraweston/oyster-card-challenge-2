class JourneyLog

  attr_reader :journeys

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    return current_journey.fare if current_journey.started?
    current_journey.entry_station = station
    0
  end

  def finish(station)
    return journey_class::PENALTY_FARE if current_journey.nil?
    current_journey.exit_station = station
    journeys << current_journey
    journey_cost = current_journey.fare
    @current_journey = nil
    journey_cost
  end

  private
  attr_reader :journey_class

  def current_journey
    @current_journey = journey_class.new if @current_journey.nil?
    @current_journey
  end
end
