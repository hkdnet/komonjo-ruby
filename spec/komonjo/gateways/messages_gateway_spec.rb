describe Komonjo::Gateway::MessagesGateway do
  let(:users) { Komonjo::Mock::SlackMock.users_list }
  let(:history) { Komonjo::Mock::SlackMock.channels_history(channel_name: 'test') }
  let(:emojis) { Hash.new }
  let(:gateway) { Komonjo::Gateway::MessagesGateway.new(history, users, emojis) }

  describe 'find_user' do
    it 'should return a user by id' do
      u1 = users[0]
      id = u1[:id]
      found = gateway.send(:find_user, id)
      expect(found.id).to eq id
    end

    it 'should throw exception with unknown user_id' do
      expect { gateway.send(:find_user, 'unknown_id') }.to raise_error
    end
  end

  describe 'messages' do
    it 'should embed users to messages' do
      gateway.messages.each do |e|
        expect(e.user).not_to be_nil
      end
    end

    describe 'the first one' do
      let(:message) { gateway.messages.first }

      it 'should be parsed into partial messages' do
        expect(message.partial_messages.size).to eq 3
      end

      describe 'the first partial_message' do
        let(:first) { message.partial_messages.first }

        it 'should embed users to messages' do
          expect(first.type).to eq :reply
          expect(first.markdown).to eq "@name001"
        end
      end
    end
  end
end
