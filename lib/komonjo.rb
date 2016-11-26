require 'json'

require 'komonjo/extensions/hash_extensions'
require 'komonjo/config'
require 'komonjo/client'
require 'komonjo/version'
require 'komonjo/connections/slack_connection'
require 'komonjo/gateways'
require 'komonjo/models'
require 'komonjo/resources'
require 'komonjo/mocks/slack_mock'
require 'komonjo/services'

module Komonjo
  class << self
    def config
      @config = Komonjo::Config.new
    end

    def configure
      yield config
    end
  end
end
