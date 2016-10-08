require 'test_helper'

describe Komonjo::Model::PartialMessage do
  describe 'with URLFilter' do
    before do
      @filters = [
        Komonjo::Model::Filter::URLFilter
      ]
      @subject = Komonjo::Model::PartialMessage.new("foo <http://example.com> bar", @filters)
    end

    it 'should return 3partial message' do
      assert { @subject.next.nil? == false }
      assert { @subject.next.next.nil? == false }
    end

    describe 'the first one' do
      it 'text == "foo "' do
        first = @subject
        assert { first.text == "foo " }
      end

      it 'type == :text' do
        first = @subject
        assert { first.type == :text }
      end
    end

    describe 'the second one' do
      it 'text == "<http://example.com>"' do
        second = @subject.next
        assert { second.text == "<http://example.com>" }
      end

      it 'type == :url' do
        second = @subject.next
        assert { second.type == :url }
      end
    end

    describe 'the third one' do
      it 'text == "foo "' do
        third = @subject.next.next
        assert { third.text == " bar" }
      end

      it 'type == :text' do
        third = @subject.next.next
        assert { third.type == :text }
      end
    end
  end
end
