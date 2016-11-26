require 'spec_helper'

describe Komonjo::Model::Filter::EmojiFilter do
  describe '.match' do
    it 'should match ":emoji:"' do
      expect(described_class.match(":emoji:")).to be_truthy
    end

    it 'should match "foo :emoji:"' do
      expect(described_class.match("foo :emoji:")).to be_truthy
    end

    it 'should match ":emoji: foo"' do
      expect(described_class.match(":emoji: foo")).to be_truthy
    end

    it 'should match "foo :emoji: bar"' do
      expect(described_class.match("foo :emoji: bar")).to be_truthy
    end
  end

  describe '.parse' do
    it 'should parse ":emoji:"' do
      parsed = described_class.parse(":emoji:")
      expect(parsed.size).to eq 1
      expect(parsed[0][:text]).to eq ":emoji:"
    end

    it 'should parse "foo :emoji:"' do
      parsed = described_class.parse("foo :emoji:")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "foo "
      expect(parsed[1][:text]).to eq ":emoji:"
    end

    it 'should parse ":emoji: foo"' do
      parsed = described_class.parse(":emoji: foo")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq ":emoji:"
      expect(parsed[1][:text]).to eq " foo"
    end

    it 'should parse "foo :emoji: bar"' do
      parsed = described_class.parse("foo :emoji: bar")
      expect(parsed.size).to eq 3
      expect(parsed[0][:text]).to eq "foo "
      expect(parsed[1][:text]).to eq ":emoji:"
      expect(parsed[2][:text]).to eq " bar"
    end

    it 'should parse ":emoji:a:emoji:"' do
      parsed = described_class.parse(":emoji:a:emoji:")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq ":emoji:"
      expect(parsed[1][:text]).to eq "a:emoji:"
    end
  end
end
