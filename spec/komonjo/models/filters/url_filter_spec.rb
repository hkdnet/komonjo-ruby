require 'spec_helper'

describe Komonjo::Model::Filter::URLFilter do
  describe '.match' do
    it 'should match "<http://example.com>"' do
      expect(described_class.match("<http://example.com>")).to be_truthy
    end

    it 'should match "foo <http://example.com>"' do
      expect(described_class.match("foo <http://example.com>")).to be_truthy
    end

    it 'should match "<http://example.com> foo"' do
      expect(described_class.match("<http://example.com> foo")).to be_truthy
    end

    it 'should match "foo <http://example.com> bar"' do
      expect(described_class.match("foo <http://example.com> bar")).to be_truthy
    end

    it 'should not match "http://"' do
      expect(described_class.match("http://")).to be_falsy
    end
  end

  describe '.parse' do
    it 'should parse "<http://example.com>"' do
      parsed = described_class.parse("<http://example.com>")
      expect(parsed.size).to eq 1
      expect(parsed[0][:text]).to eq "<http://example.com>"
    end

    it 'should parse "foo <http://example.com>"' do
      parsed = described_class.parse("foo <http://example.com>")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "foo "
      expect(parsed[1][:text]).to eq "<http://example.com>"
    end

    it 'should parse "<http://example.com> foo"' do
      parsed = described_class.parse("<http://example.com> foo")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "<http://example.com>"
      expect(parsed[1][:text]).to eq " foo"
    end

    it 'should parse "foo <http://example.com> bar"' do
      parsed = described_class.parse("foo <http://example.com> bar")
      expect(parsed.size).to eq 3
      expect(parsed[0][:text]).to eq "foo "
      expect(parsed[1][:text]).to eq "<http://example.com>"
      expect(parsed[2][:text]).to eq " bar"
    end

    it 'should parse "<http://example.com>a<http://example.com>"' do
      parsed = described_class.parse("<http://example.com>a<http://example.com>")
      expect(parsed.size).to eq 2
      expect(parsed[0][:text]).to eq "<http://example.com>"
      expect(parsed[1][:text]).to eq "a<http://example.com>"
    end
  end
end
