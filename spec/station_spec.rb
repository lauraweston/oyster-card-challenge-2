require "station"

describe Station do
  subject(:station) {described_class.new("Aldgate East", 1)}
  it "expect Station fo initialize with a name and zone" do
    expect(station).to have_attributes(name: "Aldgate East", zone: 1)
  end

end
