require "oyster_card"

describe OysterCard do
  subject(:oystercard) {described_class.new(journey_log)}
  let (:station1) {double :station1, name: "King's Cross", zone: 1}
  let (:station2) {double :station2, name: "Holborn", zone: 1}
  let(:journey_log) {double :journey_log, start: 1, finish: 1}

  it "has a default balance of 0" do
    expect(oystercard.balance).to eq(0)
  end

  context "#top_up" do
    it "tops up card" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq(10)
    end

    it "prevents top up above max" do
      oystercard.top_up(10)
      expect {oystercard.top_up(OysterCard::MAX_LIMIT)}.to raise_error("The maximum amount allowed on the card is £#{OysterCard::MAX_LIMIT}")
    end
  end

  context "#touch_in" do
    it "cannot touch in if balance less than minimum" do
      expect{oystercard.touch_in(station1)}.to raise_error "Please top up the card"
    end

    it "sets entry station in journey log" do
      oystercard.top_up(described_class::MINIMUM_BALANCE)
      oystercard.touch_in(station1)
      expect(journey_log).to have_received(:start).with station1
    end

    it "should deduct the fare from card" do
      allow(journey_log).to receive(:start) { 1 }
      oystercard.top_up(10)
      expect{oystercard.touch_in(station1)}.to change{oystercard.balance}.by(-1)
    end
  end

  context "#touch_out" do
    before do
      oystercard.top_up(described_class::MAX_LIMIT)
      oystercard.touch_in(station1)
      oystercard.touch_out(station2)
    end

    it "should deduct the fare from card" do
      allow(journey_log).to receive(:finish) { 6 }
      oystercard.touch_in(station1)
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-6)
    end

    it "sets exit station in journey log" do
      expect(journey_log).to have_received(:finish).with station2
    end
  end
end
