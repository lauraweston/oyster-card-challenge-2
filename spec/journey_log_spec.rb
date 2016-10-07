require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new }
  let(:journey) { double :journey }

  xit 'stores a list of journeys' do
     expect(journey_log.journeys).to include journey
  end
end
