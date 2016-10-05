require 'journey_log'

describe JourneyLog do
  subject(:log) {described_class.new}
  let(:journey) {double :journey}

  it "should have a current journey" do
    expect(log.current_journey).to have_attributes(entry_station: nil, exit_station: nil)
  end
  it "should store a journey" do
    log.update_log
    expect(log.journeys.last).to be_a Journey
  end
end
