require "oyster_card"

describe OysterCard do
  subject(:oystercard) {described_class.new}
  let (:station) {double('station', name: "King's Cross")}
  let (:station2) {double('station2', name: "Holborn")}

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
    xit "Touching out should deduct correct amount from card" do
      oystercard.top_up(described_class::MINIMUM_BALANCE+1)
      expect{oystercard.touch_out(station)}.to change{oystercard.balance}.by(-described_class::MINIMUM_FARE)
    end

  end

  context "#in_journey?" do
    it "Initialized not in a journey" do
      expect(oystercard.in_journey?).to eq false
    end
  end

  context "#touch_in" do
    # it "Touching in changes in_journey variable to true" do
    #   oystercard.top_up(described_class::MINIMUM_BALANCE)
    #   oystercard.touch_in(station)
    #   expect(oystercard.in_journey?).to eq true
    # end

    it "Cannot touch_in if balance less than minimum balance" do
      expect{oystercard.touch_in(station)}.to raise_error "You don't have enough money"
    end

    it "Touching in instantiates a new journey with station name" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      journey = oystercard.touch_in(station)
      expect(journey).to be_a Journey
    end

    it "Saves the entry station when touching in" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      expect(oystercard.current_journey.entry_station).to eq station.name
    end
  end

  context "#touch_out"

    xit "Touching out changes in_journey variable to false" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.in_journey?).to eq false
    end

    it "Sets current journey to nil" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      expect(oystercard.current_journey).to be nil
    end

    it "Touching out updates journey log with journey (entry and exit station)" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      expect(oystercard.journey_log.last.entry_station).to be station.name
      expect(oystercard.journey_log.last.exit_station).to be station2.name
    end
end
