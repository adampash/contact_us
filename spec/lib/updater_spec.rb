require_relative '../../lib/updater'
require 'vcr'

describe Updater do
  it "updates timestamps" do
    VCR.use_cassette('update') do
      Updater.run
    end
  end

  it "knows if it's a weekday" do
    tuesday = DateTime.new(2015, 3, 17)
    expect(Updater.is_weekday?(tuesday)).to eq true

    saturday = DateTime.new(2015, 3, 21)
    expect(Updater.is_weekday?(saturday)).to eq false
  end

  it "knows if it's morning" do
    tuesday = DateTime.new(2015, 3, 17, 14)
    expect(Updater.is_morning?(tuesday)).to eq true

    saturday = DateTime.new(2015, 3, 21, 19)
    expect(Updater.is_morning?(saturday)).to eq false
  end

  it "updates any time on weekdays, only in morning on weekends" do
    tuesday = DateTime.new(2015, 3, 17, 14)
    expect(Updater.should_update?(tuesday)).to eq true
    tuesday = DateTime.new(2015, 3, 17, 19)
    expect(Updater.should_update?(tuesday)).to eq true

    saturday = DateTime.new(2015, 3, 21, 19)
    expect(Updater.should_update?(saturday)).to eq false
    saturday = DateTime.new(2015, 3, 21, 14)
    expect(Updater.should_update?(saturday)).to eq true
  end

end
