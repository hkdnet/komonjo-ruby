describe Komonjo::Model::Message do
  describe 'markdowns' do
    describe 'to_markdown' do
      let(:timestamp) { Time.local(2006, 1, 2, 15, 4, 6) }
      let(:user) do
        Komonjo::Model::User.create(name: 'test01', profile: { image_48: 'icon_url' })
      end
      let(:message) { Komonjo::Model::Message.create(ts: timestamp, text: 'test', user: user) }

      it 'should be equal to all markdowns' do
        expected = <<-EOS.chomp
* ![test01 icon](icon_url)
\t- test01
\t- 2006-01-02 15:04:06
\t- test
        EOS
        expect(message.to_markdown).to eq expected
      end
    end
  end
end
