require 'spec_helper'

describe Talk do
  describe '#initialize' do
    it "initialize talk object" do
      talk = Talk.new("Test talk 60min")
      expect(talk.description).to eq "Test talk 60min"
      expect(talk.length).to eq 60
    end

    it "initialize talk object includes the word lightning" do
      talk = Talk.new('Test talk lightning')
      expect(talk.description).to eq 'Test talk lightning'
    end

    it "check if format is incorrect" do
      expect { Talk.new("this is a failing talk") }
        .to raise_error "incorrect format"
    end
  end
end
