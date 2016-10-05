require "journey"

describe Journey do
  subject(:journey) {described_class.new(station)}

  let (:station) {double('station', name: "King's Cross", zone: 1)}
  let (:station2) {double('station2', name: "Holborn", zone: 1)}

  it "Journey should be created with entry station name" do
    expect(journey.entry_station).to eq station.name
  end

  it "Exit station can be updated" do
    journey.exit_station = station2.name
    expect(journey.exit_station).to be station2.name
  end

end
