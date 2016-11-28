describe Komonjo::Model::Mixin::EmojiContainable do
  let(:container) do
    Struct.new(:text, :markdown) do
      prepend Komonjo::Model::Mixin::EmojiContainable
    end
  end
  subject do
    container.new(text, text)
  end
  describe '#embed' do
    context 'with :emoji:' do
      let(:text) { ":emoji:" }
      let(:data) do
        {
          emojis: [
            Komonjo::Model::Emoji.create('emoji', 'https://example.com/emoji')
          ]
        }
      end

      it 'replace :emoji: with https://example.com/emoji' do
        expect(subject.markdown).to eq ":emoji:"
        subject.embed(data)
        expect(subject.markdown).to eq "![emoji:emoji](https://example.com/emoji)"
      end
    end

    context 'with :skin-tone-1: and remove_skin_tone = false' do
      before do
        @org = Komonjo.config.remove_skin_tone
        Komonjo.config.remove_skin_tone = false
      end
      let(:text) { ":skin-tone-1:" }
      let(:data) { { emojis: {} } }
      it 'replace :skin-tone-1: with ""' do
        expect(subject.markdown).to eq ":skin-tone-1:"
        subject.embed(data)
        expect(subject.markdown).to eq ":skin-tone-1:"
      end
      after do
        Komonjo.config.remove_skin_tone = @org
      end
    end
    context 'with :skin-tone-1: and remove_skin_tone = false' do
      let(:text) { ":skin-tone-1:" }
      let(:data) { { emojis: {} } }
      before do
        @org = Komonjo.config.remove_skin_tone
        Komonjo.config.remove_skin_tone = true
      end
      it 'replace :skin-tone-1: with ""' do
        expect(subject.markdown).to eq ":skin-tone-1:"
        subject.embed(data)
        expect(subject.markdown).to eq ""
      end
      after do
        Komonjo.config.remove_skin_tone = @org
      end
    end
  end
end
