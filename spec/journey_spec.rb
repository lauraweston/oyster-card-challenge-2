require "journey"

describe Journey do
  subject(:journey) {described_class.new}
  let (:station1) {double :station1, name: "King's Cross", zone: 1}
  let (:station2) {double :station2, name: "Holborn", zone: 1}

  context "starting and finishing journeys" do
    it "Journey should be created with entry station name" do
      journey.entry_station = station1
      expect(journey.entry_station).to eq station1
    end

    it "Exit station can be updated" do
      journey.exit_station = station2
      expect(journey.exit_station).to be station2
    end
  end

  context "fares" do
    it "should return the minimum fare if valid journey" do
      journey.entry_station = station1
      journey.exit_station = station2
      expect(journey.fare).to eq described_class::MINIMUM_FARE
    end

    it "should charge penalty fare when entry station is missing" do
      journey.exit_station = station2
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end

    it "should charge penalty fare when exit station is missing" do
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end
  end
end
