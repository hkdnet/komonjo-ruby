describe Komonjo::Service::ChannelsService do
  describe 'channels' do
    it 'should be map hash to Komonjo::Model::Channel' do
      s = Komonjo::Service::ChannelsService.new nil
      class << s
        def connection(_)
          Komonjo::Mock::SlackMock
        end
      end
      s.channels.each do |e|
        expect(e.name).to match(/^channel/)
      end
    end
  end
end
