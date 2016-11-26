describe Komonjo::Service::ChannelsService do
  describe 'channels' do
    let(:service) { Komonjo::Service::ChannelsService.new(nil).mockify }
    it 'should be map hash to Komonjo::Model::Channel' do
      service.channels.each do |e|
        expect(e.name).to match(/^channel/)
      end
    end
  end
end
