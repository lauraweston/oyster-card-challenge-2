require "oyster_card"


describe OysterCard do
  subject(:oystercard) {described_class.new}
  let (:station) {double :station, name: "King's Cross", zone: 1}
  let (:station2) {double :station2, name: "Holborn", zone: 1}
  let (:journey) {double :journey }
  let(:journey_log) {double :journey_log }

  it "has a default balance of 0" do
    expect(oystercard.balance).to eq(0)
  end

  context "#top_up" do
    it "responds to top_up" do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it "tops up card" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq(10)
    end

    it "prevents top up above 90" do
      expect{oystercard.top_up(described_class::MAX_LIMIT+1)}.to raise_error("The maximum amount allowed on the card is £90")
    end
  end

  context "#deduct" do
    it "Touching out should deduct correct amount from card" do
      oystercard.top_up(described_class::MINIMUM_BALANCE+1)
      oystercard.touch_in(station)
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-Journey::MINIMUM_FARE)
    end

    it "Cannot touch_in if balance less than minimum balance" do
      expect{oystercard.touch_in(station)}.to raise_error "You don't have enough money"
    end

    it "Touching in sets entry station with station" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect(oystercard.current_journey.entry_station).to be station
    end

    it "Saves the entry station when touching in" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect(oystercard.current_journey.entry_station).to be station
    end
  end

  context "#touch_out" do
    before do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
    end

    it "Sets current journey to nil" do
      expect(oystercard.current_journey).to have_attributes(entry_station: nil, exit_station: nil)
    end

    it "Touching out updates journey log with journey (entry and exit station)" do
      expect(oystercard.journey_log.last.entry_station).to be station
      expect(oystercard.journey_log.last.exit_station).to be station2
    end
  end

  context "Touching out without touching in" do
    it "Touching out without touching in incurs a penalty charge" do
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end

    it "Touching out without touching in resets current_journey" do
      oystercard.touch_out(station2)
      expect(oystercard.current_journey).to have_attributes(entry_station: nil, exit_station: nil)
    end

    it "Touching out updates journey log with journey (entry and exit station)" do
      oystercard.touch_out(station2)
      expect(oystercard.journey_log.last.entry_station).to be nil
      expect(oystercard.journey_log.last.exit_station).to be station2
    end
  end

  context "Touching in twice" do
    before do
      oystercard.top_up(described_class::MAX_LIMIT)
      oystercard.touch_in(station)
    end

    it "Touching in twice incurs a penalty charge for the first journey" do
      expect{oystercard.touch_in(station2)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end
  end
end
