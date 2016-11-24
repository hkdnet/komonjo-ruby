require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'komonjo'
require 'komonjo/mocks/slack_mock'
