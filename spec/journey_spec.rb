require "journey"

describe Journey do
  subject(:station) {Station.new("Brixton", 2)}
  subject(:journey) {described_class.new(station)}
  subject(:station2) {Station.new("Southwark", 1)}
  it "journey should be created with entry station name" do
    expect(journey.entry_station).to eq station.name
  end
  it "journey should end with exit station name" do
    expect(journey.exit_station).to eq station2.name
  end
end
