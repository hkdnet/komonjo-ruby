describe Komonjo::Model::Message do
  describe 'markdowns' do
    describe 'to_markdown' do
      let(:timestamp) { Time.local(2006, 1, 2, 15, 4, 6) }
      let(:user) do
        Komonjo::Model::User.create(name: 'test01', profile: { image_48: 'icon_url' })
      end
      let(:message) { Komonjo::Model::Message.create(ts: timestamp, text: 'test', user: user) }

      it 'should return non-nested icon' do
        expect(message.icon_markdown).to eq "* ![test01 icon](icon_url)\n"
      end

      it 'should return nested name' do
        expect(message.name_markdown).to eq "\t- test01\n"
      end

      it 'should return nested ts' do
        expect(message.ts_markdown).to eq "\t- 2006-01-02 15:04:06\n"
      end

      it 'should return nested text' do
        expect(message.text_markdown).to eq "\t- test\n"
      end

      it 'should be equal to all markdowns' do
        expect(message.to_markdown).to eq [
          message.icon_markdown,
          message.name_markdown,
          message.ts_markdown,
          message.text_markdown
        ].join
      end
    end
  end
end
