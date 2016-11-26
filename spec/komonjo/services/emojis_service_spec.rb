describe Komonjo::Service::EmojisService do
  describe 'emoji' do
    let(:service) { Komonjo::Service::EmojisService.new(nil).mockify }
    it 'should be map hash to Komonjo::Model::Channel' do
      service.emoji.each do |e|
        expect(e.name).not_to be_nil
        expect(e.url).not_to be_nil
      end
    end
  end
end
