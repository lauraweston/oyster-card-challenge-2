require "journey_log"

describe JourneyLog do
  subject(:journey_log) { described_class.new(Journey) }
  let(:journey) { double :journey }
  let (:entry_station) {double :entry_station, name: "King's Cross", zone: 1}
  let (:exit_station) {double :exit_station, name: "Holborn", zone: 1}

  it "should start a new journey with an entry station" do
    journey_log.start(entry_station)
  end

  it "should finish a journey with an exit station" do
    journey_log.start(entry_station)
    journey_log.finish(exit_station)
    expect(journey_log.journeys.length).to eq 1
    expect(journey_log.journeys.first.entry_station).to eq entry_station
    expect(journey_log.journeys.first.exit_station).to eq exit_station
  end

  it "should charge a fare for a finished journey" do
    journey_log.start(entry_station)
    journey_cost = journey_log.finish(exit_station)
    expect(journey_cost).to eq Journey::MINIMUM_FARE
  end

  it "should charge nothing for a start to a new journey" do
    journey_cost = journey_log.start(entry_station)
    expect(journey_cost).to eq 0
  end

  it "should charge penalty fare for touching in twice" do
    journey_log.start(entry_station)
    journey_cost = journey_log.start(entry_station)
    expect(journey_cost).to eq Journey::PENALTY_FARE
  end

  it "should charge penalty fare for touching out twice" do
    journey_log.start(entry_station)
    journey_log.finish(exit_station)
    journey_cost = journey_log.finish(exit_station)
    expect(journey_cost).to eq Journey::PENALTY_FARE
  end
end
