describe Komonjo::Service::EmojisService do
  describe 'emoji' do
    s = Komonjo::Service::EmojisService.new nil
    class << s
      def connection(_)
        Komonjo::Mock::SlackMock
      end
    end
    it 'should be map hash to Komonjo::Model::Channel' do
      s.emoji.each do |e|
        expect(e.name).not_to be_nil
        expect(e.url).not_to be_nil
      end
    end
  end
end
