require "oyster_card"

describe OysterCard do
  subject {OysterCard.new}
  it "has a default balance of 0" do
    expect(subject.balance).to eq(0)
  end
  context '#top_up' do
    it "responds to top_up" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it "tops up card" do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end
  end
end
