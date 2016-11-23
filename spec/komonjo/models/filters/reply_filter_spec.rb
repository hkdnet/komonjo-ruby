require 'spec_helper'

describe Komonjo::Model::Filter::ReplyFilter do
  describe '.match' do
    it 'should match "<@ABCDEF>"' do
      expect(described_class.match("<@ABCDEF>")).to be_truthy
    end

    it 'should match "foo <@ABCDEF>"' do
      expect(described_class.match("foo <@ABCDEF>")).to be_truthy
    end

    it 'should match "<@ABCDEF> foo"' do
      expect(described_class.match("<@ABCDEF> foo")).to be_truthy
    end

    it 'should match "foo <@ABCDEF> bar"' do
      expect(described_class.match("foo <@ABCDEF> bar")).to be_truthy
    end

    it 'should not match "@ABCDE"' do
      expect(described_class.match("@ABCDE")).to be_falsy
    end
  end

  describe '.parse' do
    it 'should parse "<@ABCDEF>"' do
      parsed = described_class.parse("<@ABCDEF>")
      expect(parsed.size).to eq 1
      expect(parsed[0][:text]).to eq "<@ABCDEF>"
    end

    it 'should parse "foo <@ABCDEF>"' do
      parsed = described_class.parse("foo <@ABCDEF>")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "foo "
      expect(parsed[1][:text]).to eq "<@ABCDEF>"
    end

    it 'should parse "<@ABCDEF> foo"' do
      parsed = described_class.parse("<@ABCDEF> foo")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "<@ABCDEF>"
      expect(parsed[1][:text]).to eq " foo"
    end

    it 'should parse "foo <@ABCDEF> bar"' do
      parsed = described_class.parse("foo <@ABCDEF> bar")
      expect(parsed.size).to eq 3
      expect(parsed[0][:text]).to eq "foo "
      expect(parsed[1][:text]).to eq "<@ABCDEF>"
      expect(parsed[2][:text]).to eq " bar"
    end

    it 'should parse "<@ABCDEF>a<@ABCDEF>"' do
      parsed = described_class.parse("<@ABCDEF>a<@ABCDEF>")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "<@ABCDEF>"
      expect(parsed[1][:text]).to eq "a<@ABCDEF>"
    end
  end
end
