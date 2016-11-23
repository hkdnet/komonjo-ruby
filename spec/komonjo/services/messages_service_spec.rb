describe Komonjo::Service::MessagesService do
  describe 'channels' do
    it 'should be map hash to Komonjo::Model::Message' do
      s = Komonjo::Service::MessagesService.new nil
      class << s
        def connection(_)
          Komonjo::Mock::SlackMock
        end
      end
      s.messages(channel_name: :test_channel).each do |e|
        expect(e.user.id).to match(/^id00\d/)
      end
    end
  end
end
