require_relative '../../lib/updater'
require 'vcr'

describe Updater do
  it "updates timestamps" do
    VCR.use_cassette('update') do
      Updater.run
    end
  end
end
