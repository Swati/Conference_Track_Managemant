require 'spec_helper'

describe Scheduler do

  before :all do
    @list = []
    File.readlines("#{Dir.pwd}/data/data.txt").each{|line| @list << Talk.new(line.gsub(/\n/, ''))}
  end

  describe "#schedule" do
    before do
      @tracks = Scheduler.new.schedule(@list)
    end

    it "should have maximum 2 tracks" do
      expect(@tracks.length).to eq 2
    end

    it "schedule talks and returns array of tracks" do
      @tracks.each do |track|
        expect(track.morning_session.map(&:length).inject(:+)).to be <= 180
        expect(track.afternoon_session.map(&:length).inject(:+)).to be <= 240
      end
    end

    it "should match the total tracks length is equal to input talks length" do
      sum = 0
      @tracks.each do |track|
        sum += track.morning_session.map(&:length).inject(:+) + track.afternoon_session.map(&:length).inject(:+)
      end
      expect(sum).to eq @list.map(&:length).inject(:+)
    end
  end

  describe "#schedule_talks" do
    before do
      @talks, @schedule_talks = Scheduler.new.schedule_talks(@list, 180)
    end

    it "returns schedule talks and talks" do
      expect(@schedule_talks.map(&:length).inject(:+)).to be <= 180
    end
  end

end
