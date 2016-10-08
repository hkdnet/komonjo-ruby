require 'test_helper'

describe Komonjo::Gateway::MessagesGateway do
  before do
    @users = Komonjo::Mock::SlackMock.users_list
    @history = Komonjo::Mock::SlackMock.channels_history 'test'
    @emojis = {}
    @gateway = Komonjo::Gateway::MessagesGateway.new(@history, @users, @emojis)
  end

  describe 'find_user' do
    it 'should return a user by id' do
      u1 = @users[0]
      id = u1[:id]
      found = @gateway.send :find_user, id
      assert { found.class == Komonjo::Model::User }
      assert { found.id == id }
    end

    it 'should throw exception with unknown user_id' do
      begin
        @gateway.send :find_user, 'unknown_id'
        assert false, 'this line should not be executed because' \
          'find_user should throw unknown user exception'
      rescue
        assert true
      end
    end
  end

  describe 'messages' do
    it 'should embed users to messages' do
      @gateway.messages.each do |e|
        assert { e.class == Komonjo::Model::Message }
        assert { e.user.class == Komonjo::Model::User }
      end
    end
  end
end
