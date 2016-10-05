require 'journey'

class JourneyLog
  attr_reader :current_journey, :journeys

  def initialize
    @current_journey = Journey.new
    @journeys = []
  end

  def update_log
    journeys << current_journey
  end
end
