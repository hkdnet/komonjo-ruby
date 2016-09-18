require 'test_helper'

module Komonjo
  module Gateway
    # test for messages gateway
    module EmojisGatewayTest
      describe 'emoji' do
        it 'should resolve alias' do
          emoji_list = Komonjo::Mock::SlackMock.emoji_list
          g = Komonjo::Gateway::EmojisGateway.new(emoji_list)
          shipit = g.emoji.find { |e| e.name == 'shipit' }
          squirrel = g.emoji.find { |e| e.name == 'squirrel' }
          assert { !shipit.nil? }
          assert { !squirrel.nil? }
          assert { shipit.alias? }
          assert { shipit.url == squirrel.url }
        end
      end
    end
  end
end
