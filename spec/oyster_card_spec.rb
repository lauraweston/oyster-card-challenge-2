require "oyster_card"

describe OysterCard do
  subject {OysterCard.new}
  it "has a default balance of 0" do
    expect(subject.balance).to eq(0)
  end
  context "#top_up" do
    it "responds to top_up" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it "tops up card" do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end
    it "prevents top up above 90" do
      MAX_LIMIT = 90
      subject.top_up(90)
      expect{subject.top_up(1)}.to raise_error("The maximum amount allowed on the card is £90")
    end
  end
  context "#deduct" do
    it "responds to deduct" do
      expect(subject).to respond_to(:deduct).with(1).argument
    end
    it "deducts fare" do
      subject.top_up(20) # replace with stub
      subject.deduct(10)
      expect(subject.balance).to eq(10)
    end
  end
end
