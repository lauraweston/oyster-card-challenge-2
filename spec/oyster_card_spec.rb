require "oyster_card"

describe OysterCard do
  subject {OysterCard.new}
  it "has a default balance of 0" do
    expect(subject.balance).to eq(0)
  end
end
