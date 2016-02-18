require 'test_helper'

describe Komonjo do
  it 'should has a version number' do
    assert { ::Komonjo::VERSION.nil? == false }
  end
end
