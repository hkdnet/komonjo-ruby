describe Komonjo::Model::PartialMessage do
  describe 'with URLFilter' do
    let(:filters) { [Komonjo::Model::Filter::URLFilter] }
    let(:partial) { described_class.new("foo <http://example.com> bar", filters) }

    it 'should return 3partial message' do
      expect(partial.next).not_to be_nil
      expect(partial.next.next).not_to be_nil
    end

    describe 'the first one' do
      subject { partial }
      it 'text == "foo "' do
        expect(subject.text).to eq "foo "
      end

      it 'type == :text' do
        expect(subject.type).to eq :text
      end
    end

    describe 'the second one' do
      subject { partial.next }
      it 'text == "<http://example.com>"' do
        expect(subject.text).to eq "<http://example.com>"
      end

      it 'type == :url' do
        expect(subject.type).to eq :url
      end

      describe 'embed' do
        it "replace text with markdown link" do
          subject.embed({})
          expect(subject.markdown).to eq "[http://example.com](http://example.com)"
        end
      end
    end

    describe 'the third one' do
      subject { partial.next.next }
      it 'text == " bar"' do
        expect(subject.text).to eq " bar"
      end

      it 'type == :text' do
        expect(subject.type).to eq :text
      end
    end
  end

  describe 'with ReplyFilter' do
    let(:filters) { [Komonjo::Model::Filter::ReplyFilter] }
    let(:partial) { described_class.new("foo <@ABCDEF> bar", filters) }
    let(:users) { [Komonjo::Model::User.create(id: 'ABCDEF', name: 'hoge')] }

    it 'should return 3partial message' do
      expect(partial.next).not_to be_nil
      expect(partial.next.next).not_to be_nil
    end

    describe 'the first one' do
      subject { partial }
      it 'text == "foo "' do
        expect(subject.text).to eq "foo "
      end

      it 'type == :text' do
        expect(subject.type).to eq :text
      end
    end

    describe 'the second one' do
      subject { partial.next }
      it 'text == "<@ABCDEF>"' do
        expect(subject.text).to eq "<@ABCDEF>"
      end

      it 'type == :reply' do
        expect(subject.type).to eq :reply
      end

      describe 'embed' do
        it "replace text with user\'s name" do
          subject.embed(users: users)
          expect(subject.markdown).to eq "@hoge"
        end
      end
    end

    describe 'the third one' do
      subject { partial.next.next }
      it 'text == " bar"' do
        expect(subject.text).to eq " bar"
      end

      it 'type == :text' do
        expect(subject.type).to eq :text
      end
    end
  end

  describe 'with EmojiFilter' do
    let(:filters) { [Komonjo::Model::Filter::EmojiFilter] }
    let(:partial) { described_class.new("foo :emoji: bar", filters) }
    let(:emojis) { [Komonjo::Model::Emoji.create('emoji', 'http://example.com')] }

    it 'should return 3partial message' do
      expect(partial.next).not_to be_nil
      expect(partial.next.next).not_to be_nil
    end

    describe 'the first one' do
      subject { partial }
      it 'text == "foo "' do
        expect(subject.text).to eq "foo "
      end

      it 'type == :text' do
        expect(subject.type).to eq :text
      end
    end

    describe 'the second one' do
      subject { partial.next }
      it 'text == ":emoji:"' do
        expect(subject.text).to eq ":emoji:"
      end

      it 'type == :emoji' do
        expect(subject.type).to eq :emoji
      end

      describe 'embed' do
        it "replace text with markdown image" do
          subject.embed(emojis: emojis)
          expect(subject.markdown).to eq "![emoji:emoji](http://example.com)"
        end
      end
    end

    describe 'the third one' do
      subject { partial.next.next }
      it 'text == " bar"' do
        expect(subject.text).to eq " bar"
      end

      it 'type == :text' do
        expect(subject.type).to eq :text
      end
    end
  end
end
