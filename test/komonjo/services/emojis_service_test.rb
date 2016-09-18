require 'test_helper'

module KomonjoTest
  module Service
    # test for Komonjo::Service::EmojisService
    module EmojisServiceTest
      describe Komonjo::Service::EmojisService do
        describe 'initialize' do
          it 'should be able to set nil as @api_token' do
            s = Komonjo::Service::EmojisService.new nil
            assert { s.instance_variable_get(:@api_token).nil? }
          end
          it 'should be able to set param as @api_token' do
            s = Komonjo::Service::EmojisService.new :hoge
            assert { s.instance_variable_get(:@api_token) == :hoge }
          end
        end
        describe 'emoji' do
          s = Komonjo::Service::EmojisService.new nil
          class << s
            def connection(_)
              Komonjo::Mock::SlackMock
            end
          end
          it 'should be map hash to Komonjo::Model::Channel' do
            s.emoji.each do |e|
              assert { e.class == Komonjo::Model::Emoji }
              assert { !e.name.nil? }
              assert { !e.url.nil? }
            end
          end
        end
      end
    end
  end
end
