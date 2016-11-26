describe Komonjo::Service::MessagesService do
  describe 'channels' do
    let(:service) { Komonjo::Service::MessagesService.new(nil).mockify }
    it 'should be map hash to Komonjo::Model::Message' do
      service.messages(channel_name: :test_channel).each do |e|
        expect(e.user.id).to match(/^id00\d/)
      end
    end
  end
end
