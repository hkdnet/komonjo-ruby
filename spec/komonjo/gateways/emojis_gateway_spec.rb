describe Komonjo::Gateway::EmojisGateway do
  let(:emoji_list) { Komonjo::Mock::SlackMock.emoji_list }
  let(:gateway) { Komonjo::Gateway::EmojisGateway.new(emoji_list) }
  let(:shipit) { gateway.emoji.find { |e| e.name == 'shipit' } }
  let(:squirrel) { gateway.emoji.find { |e| e.name == 'squirrel' } }
  describe 'shipit' do
    it { expect(shipit).to be_alias }
    it 'can resolve alias' do
      expect(shipit.url).to eq squirrel.url
    end
  end
end
