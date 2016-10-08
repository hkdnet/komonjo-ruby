require 'test_helper'

describe Komonjo::Model::Filter::ReplyFilter do
  describe '.match' do
    it 'should match "<@ABCDEF>"' do
      assert { Komonjo::Model::Filter::ReplyFilter.match("<@ABCDEF>") }
    end

    it 'should match "foo <@ABCDEF>"' do
      assert { Komonjo::Model::Filter::ReplyFilter.match("foo <@ABCDEF>") }
    end

    it 'should match "<@ABCDEF> foo"' do
      assert { Komonjo::Model::Filter::ReplyFilter.match("<@ABCDEF> foo") }
    end

    it 'should match "foo <@ABCDEF> bar"' do
      assert { Komonjo::Model::Filter::ReplyFilter.match("foo <@ABCDEF> bar") }
    end

    it 'should not match "@ABCDE"' do
      assert { !Komonjo::Model::Filter::ReplyFilter.match("@ABCDE") }
    end
  end

  describe '.parse' do
    it 'should parse "<@ABCDEF>"' do
      parsed = Komonjo::Model::Filter::ReplyFilter.parse("<@ABCDEF>")
      assert { parsed.size == 1 }
      assert { parsed[0] == "<@ABCDEF>" }
    end

    it 'should parse "foo <@ABCDEF>"' do
      parsed = Komonjo::Model::Filter::ReplyFilter.parse("foo <@ABCDEF>")
      assert { parsed.size == 2 }
      assert { parsed[0] == "foo " }
      assert { parsed[1] == "<@ABCDEF>" }
    end

    it 'should parse "<@ABCDEF> foo"' do
      parsed = Komonjo::Model::Filter::ReplyFilter.parse("<@ABCDEF> foo")
      assert { parsed.size == 2 }
      assert { parsed[0] == "<@ABCDEF>" }
      assert { parsed[1] == " foo" }
    end

    it 'should parse "foo <@ABCDEF> bar"' do
      parsed = Komonjo::Model::Filter::ReplyFilter.parse("foo <@ABCDEF> bar")
      assert { parsed.size == 3 }
      assert { parsed[0] == "foo " }
      assert { parsed[1] == "<@ABCDEF>" }
      assert { parsed[2] == " bar" }
    end

    it 'should parse "<@ABCDEF>a<@ABCDEF>"' do
      parsed = Komonjo::Model::Filter::ReplyFilter.parse("<@ABCDEF>a<@ABCDEF>")
      assert { parsed.size == 2 }
      assert { parsed[0] == "<@ABCDEF>" }
      assert { parsed[1] == "a<@ABCDEF>" }
    end
  end
end
