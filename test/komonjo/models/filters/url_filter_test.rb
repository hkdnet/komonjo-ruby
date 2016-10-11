require 'test_helper'

describe Komonjo::Model::Filter::URLFilter do
  describe '.match' do
    it 'should match "<http://example.com>"' do
      assert { Komonjo::Model::Filter::URLFilter.match("<http://example.com>") }
    end

    it 'should match "foo <http://example.com>"' do
      assert { Komonjo::Model::Filter::URLFilter.match("foo <http://example.com>") }
    end

    it 'should match "<http://example.com> foo"' do
      assert { Komonjo::Model::Filter::URLFilter.match("<http://example.com> foo") }
    end

    it 'should match "foo <http://example.com> bar"' do
      assert { Komonjo::Model::Filter::URLFilter.match("foo <http://example.com> bar") }
    end

    it 'should not match "http://"' do
      assert { !Komonjo::Model::Filter::URLFilter.match("http://") }
    end
  end

  describe '.parse' do
    it 'should parse "<http://example.com>"' do
      parsed = Komonjo::Model::Filter::URLFilter.parse("<http://example.com>")
      assert { parsed.size == 1 }
      assert { parsed[0][:text] == "<http://example.com>" }
    end

    it 'should parse "foo <http://example.com>"' do
      parsed = Komonjo::Model::Filter::URLFilter.parse("foo <http://example.com>")
      assert { parsed.size == 2 }
      assert { parsed[0][:text] == "foo " }
      assert { parsed[1][:text] == "<http://example.com>" }
    end

    it 'should parse "<http://example.com> foo"' do
      parsed = Komonjo::Model::Filter::URLFilter.parse("<http://example.com> foo")
      assert { parsed.size == 2 }
      assert { parsed[0][:text] == "<http://example.com>" }
      assert { parsed[1][:text] == " foo" }
    end

    it 'should parse "foo <http://example.com> bar"' do
      parsed = Komonjo::Model::Filter::URLFilter.parse("foo <http://example.com> bar")
      assert { parsed.size == 3 }
      assert { parsed[0][:text] == "foo " }
      assert { parsed[1][:text] == "<http://example.com>" }
      assert { parsed[2][:text] == " bar" }
    end

    it 'should parse "<http://example.com>a<http://example.com>"' do
      parsed = Komonjo::Model::Filter::URLFilter.parse("<http://example.com>a<http://example.com>")
      assert { parsed.size == 2 }
      assert { parsed[0][:text] == "<http://example.com>" }
      assert { parsed[1][:text] == "a<http://example.com>" }
    end
  end
end
