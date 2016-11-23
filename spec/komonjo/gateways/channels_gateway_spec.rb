describe Komonjo::Gateway::ChannelsGateway do
  let(:raw_channles) { Komonjo::Mock::SlackMock.channels_list }
  let(:gateway) { Komonjo::Gateway::ChannelsGateway.new(raw_channles) }
  describe 'channels' do
    let(:channels) { gateway.channels }
    it 'should embed users to messages' do
      channels.each do |e|
        expect(e.name).to match(/^channel/)
      end
    end
  end
end
