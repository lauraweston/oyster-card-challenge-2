require "oyster_card"

describe OysterCard do
  subject(:oystercard) {described_class.new}

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
      MAX_LIMIT = 90
      oystercard.top_up(90)
      expect{oystercard.top_up(1)}.to raise_error("The maximum amount allowed on the card is £90")
    end
  end

  context "#deduct" do
    it "responds to deduct" do
      expect(oystercard).to respond_to(:deduct).with(1).argument
    end

    it "deducts fare" do
      oystercard.top_up(20) # replace with stub
      oystercard.deduct(10)
      expect(oystercard.balance).to eq(10)
    end
  end

  context "#in_journey?" do
    it "Initialized not in a journey" do
      expect(oystercard.in_journey?).to eq false
    end
  end

  context "#touch_in" do
    it "Touching in changes in_journey variable to true" do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end
  end

  context "#touch_out"
    it "Touching out changes in_journey variable to false" do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end
end
