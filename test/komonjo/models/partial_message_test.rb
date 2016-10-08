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

  describe 'with ReplyFilter' do
    before do
      @filters = [
        Komonjo::Model::Filter::ReplyFilter
      ]
      @subject = Komonjo::Model::PartialMessage.new("foo <@ABCDEF> bar", @filters)
      @users = [
        Komonjo::Model::User.create(id: 'ABCDEF', name: 'hoge')
      ]
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
      it 'text == "<@ABCDEF>"' do
        second = @subject.next
        assert { second.text == "<@ABCDEF>" }
      end

      it 'type == :reply' do
        second = @subject.next
        assert { second.type == :reply }
      end

      describe 'embed' do
        it "replace text with user\'s name" do
          second = @subject.next
          second.embed(users: @users)
          assert { second.text == "@hoge" }
        end
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

  describe 'with EmojiFilter' do
    before do
      @filters = [
        Komonjo::Model::Filter::EmojiFilter
      ]
      @subject = Komonjo::Model::PartialMessage.new("foo :emoji: bar", @filters)
      @emojis = [
        Komonjo::Model::Emoji.create('emoji', 'http://example.com')
      ]
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
      it 'text == ":emoji:"' do
        second = @subject.next
        assert { second.text == ":emoji:" }
      end

      it 'type == :emoji' do
        second = @subject.next
        assert { second.type == :emoji }
      end

      describe 'embed' do
        it "replace text with markdown image" do
          second = @subject.next
          second.embed(emojis: @emojis)
          assert { second.text == "![emoji:emoji](http://example.com)" }
        end
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
